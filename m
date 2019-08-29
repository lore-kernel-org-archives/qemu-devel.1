Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBA3C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1239320828
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1239320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3ICX-0003tF-8l
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 07:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i3IAS-0001uG-OJ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i3IAN-0004hk-M4
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i3IAN-0004es-D6
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:00:35 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8E1B280F83
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:00:33 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id a2so1912951wrs.8
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 04:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=FpMnTmb5EK3T59v0tQYnix1Jw97lGeI9LMYeRfZjh0I=;
 b=WvwsweXOtG6MA+29DxEjpW7cEyknPqbQ7bKyE/sdbDwCr7K0AjHdnOs1vmz3t+q2Ga
 QXjfMSW4/2Q0KQEkx6dcw9h08YZ3WWJeLwEDUVuID5DZ7zbn1vCQ8R33QJBUAu7EDEsD
 8+HqWn2+8PTFV+lmj6kZ+BTVQ+hTiVnhARs2poOFeeN9A31nsXgjmsUc6hWeeaUgvfSM
 iLfN8/H0xsxg3ztsoFVnv2iz9PnwCbQ5+4y3HT5bmv37QGtzKXwcvAZFLaS3FUsyigeT
 QvcnvGNFY29Lf4f00DGSEgE4t3BlSgPdXCjxViU/+qKRMQoTtW7pTL3VCA9wbjqDm/9C
 zerg==
X-Gm-Message-State: APjAAAWu+exZZjB02QC34dB25DUv7CafXjEwFqHXqKdthEpctezeTuql
 ivf0e+tff69hUjWzuMkEbtdEvU/on8Xn0lzZnS65N7ZD3FxJbD+0Fmnq8N5nqcGRgaIRfL0OIKD
 FN+HVaMKo3AjZNOY=
X-Received: by 2002:a7b:c7c4:: with SMTP id z4mr10665767wmk.13.1567076431321; 
 Thu, 29 Aug 2019 04:00:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkm88hBb9dzkqkMHBLc1jNs6wV9uEEez66102RTb2itMKCp8Ql2Oo8gQZuAF6OoUPxV7zo8g==
X-Received: by 2002:a7b:c7c4:: with SMTP id z4mr10665733wmk.13.1567076431059; 
 Thu, 29 Aug 2019 04:00:31 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id 2sm3004575wmz.16.2019.08.29.04.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 04:00:30 -0700 (PDT)
Date: Thu, 29 Aug 2019 13:00:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190829110028.35grhbtdnr7uvavq@steredhat>
References: <20190829100521.12143-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190829100521.12143-1-philmd@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] git.orderfile: Order
 Python/shell scripts before unordered files
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 12:05:19PM +0200, Philippe Mathieu-Daud=E9 wrote:
> This series update the git.orderfile to order Python and shell
> scripts before unordered files.
> This is particularly useful for changes in tests/qemu-iotests.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (2):
>   scripts/git.orderfile: Order Python files before unordered ones
>   scripts/git.orderfile: Order shell scripts before unordered files
>=20
>  scripts/git.orderfile | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

