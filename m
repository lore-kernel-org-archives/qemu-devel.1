Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F005C35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0D9222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LezRnyGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0D9222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54wy-00016f-Ue
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j54uO-0006Lf-3Z
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j54uN-000770-5K
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:47:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j54uN-00075k-1O
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582278462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Se12IwhABkMpwMomB3ITQ2ynSwiJ5gxQVNaBMiIBya0=;
 b=LezRnyGMU0DQ4htY0G3yMA+o+6lSnleo98kw24eqKnmAWnQmJtr4rCuWEnn8sdGYO38XcN
 8kLzIPws5RedbsoIQSpVlSM5i55cKGbmerJqe11NXpsRYbOyuqQPO/vE5Xj5A7wpEhlDyK
 qkTOzWP29TRKFZxOvDIzrQwUAvsK2I8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-QxEOuDAtOhGXTAKXP3gI1w-1; Fri, 21 Feb 2020 04:47:41 -0500
X-MC-Unique: QxEOuDAtOhGXTAKXP3gI1w-1
Received: by mail-wr1-f72.google.com with SMTP id c6so769945wrm.18
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 01:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jag29nL/+lr4Lx24TK8cqqM42UrldPUBANMdtnAkGEY=;
 b=DBmj4In+yp44oKL6MlO6BME2ANFJm9tIbSoykcRCTBYhUf3ADUAC11EcQUNan+7rvv
 pJBZGxVLubxch8b/8j9MXETT/CqS3LxfLIU22LEFPLeXFQnOwqIbTbzlPYoL45J7jE7u
 kPMSagWn2MKVHPtoTb/40aVUdB5LNej6+G8Q9UFH4V2WE9uVGw1s2AnGmxRejI4v4zbf
 Rtm3ZqgFdpFTFH76RBdnwGliI+CqIk5kgo09qnh3dOYDhoJumJhQ8EJBOlllSNj3lYTj
 C2CWebdEa6Q13DOQnO1sM0DnzE4y/TR/XyOcyRBA5sxmJ9lJ+TPP1KMai/8kcOjPT+vt
 c8/Q==
X-Gm-Message-State: APjAAAXR2QyUb7IVC6brxA51Rs/ugmpFpcLUmY6CvFaYPvp3pVJCM2nW
 LZT66NqmhNXDyZwK8EHEu8PPiPd1SF36CyB4x+fssfTF0bSv3AYk74+Ay53kR9C6tQOhT7OQB7m
 UGmEio28QvsbbUqo=
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr2733354wma.111.1582278460011; 
 Fri, 21 Feb 2020 01:47:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOXtIm4lbiDZUim0gGl4pBbuH0Sk4s0jjdCa2EE97URrSWmDXUuqY4iLPX9hHP1OT2gyGGpw==
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr2733333wma.111.1582278459857; 
 Fri, 21 Feb 2020 01:47:39 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i16sm3136177wrr.71.2020.02.21.01.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 01:47:39 -0800 (PST)
Subject: Re: [PATCH] virtiofsd: Remove fuse.h and struct fuse_module
To: Xiao Yang <yangx.jy@cn.fujitsu.com>, virtio-fs@redhat.com
References: <20200221065515.4476-1-yangx.jy@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <96dca240-e221-a4ab-4f8f-198891c1b16a@redhat.com>
Date: Fri, 21 Feb 2020 10:47:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221065515.4476-1-yangx.jy@cn.fujitsu.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 7:55 AM, Xiao Yang wrote:
> All code in fuse.h and struct fuse_module are not used by virtiofsd
> so removing them is safe.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>   tools/virtiofsd/fuse.h   | 1229 --------------------------------------
>   tools/virtiofsd/fuse_i.h |   16 -
>   2 files changed, 1245 deletions(-)
>   delete mode 100644 tools/virtiofsd/fuse.h

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


