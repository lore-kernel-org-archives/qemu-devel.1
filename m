Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8CBC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590C92086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="N/8f7v95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590C92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw2Q7-0006Ym-Mi
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hw2Pd-0005m2-M2
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hw2Pc-0003v6-PE
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:46:21 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:52362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hw2PY-0003su-LG; Fri, 09 Aug 2019 06:46:17 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id EC29D96F50;
 Fri,  9 Aug 2019 10:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1565347574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnkqnHk+vQTs3+v+TeLAAZrDC9Y0NDTxEX/bVDYcIuo=;
 b=N/8f7v95XEek/VtUemL0Ko8tdVIf1gu6pCtv04nH/+bToeRIgQCpGKCys8wrFgnFZfi60c
 4Sy7Ry9E8Wk56UIH655vnnI7ZsdVfzc/fPF/+S453f5RX2/Z2ozsfWYzYknPo4Q3Yrw/Fl
 5ht9HTOHImLccCeBqdN636WTBd4V+68=
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-8-damien.hedde@greensocs.com>
 <CAFEAcA-W0SaaGbUnGZ0b61ngxKY8R9xjwGXeN+=MaUi4bMDgNg@mail.gmail.com>
 <20190808154219.GK2852@work-vm>
 <CAFEAcA8L2YVMCu3Gb+eQTDfCpgVwA_WwVPrqPLV2iQ9rZ4HuTA@mail.gmail.com>
 <f400248f-7a3b-83e9-3355-77de359e3f43@greensocs.com>
 <CAFEAcA-YjLA25wPBgWOB_c2fV2o7C8n=1-uUVe6xgiP=j5+Fgw@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <69a53af1-7007-7b80-8e6c-62ebabba8a62@greensocs.com>
Date: Fri, 9 Aug 2019 12:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-YjLA25wPBgWOB_c2fV2o7C8n=1-uUVe6xgiP=j5+Fgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1565347574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnkqnHk+vQTs3+v+TeLAAZrDC9Y0NDTxEX/bVDYcIuo=;
 b=oxaEOf7LiU0EPllSyM2H5aK1u2+F2oCiWJ47qgBYjMahGZcHFtpz+EN695b7A+PYrtg1fK
 LWIwBJp8PPWzRmiqEFIiTVsIB3CBSVOeE+pwlEmLwUWBubxzixKJGdXi3yck6/kdcc+JtZ
 eGzHWpP788Ck4G/+wbCelvGkZfrTKYs=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1565347574; a=rsa-sha256; cv=none;
 b=YRnummxROKcsvaNwAJubpjBaacDxsO3kYUBQz+YtbZFXZmL36x/yYAirUcyfB5nk0O7QDd
 NDcMCakOkODinGEF3R+vzgLTkGYycU9cOU399DFPfo28zDWmU8Cs35Oc/HZ758McNo697Z
 JGuurQRU05rVw7gIUa3b+Y72K8z/6ds=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 07/33] automatically add vmstate for
 reset support in devices
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 8/9/19 12:32 PM, Peter Maydell wrote:
> On Fri, 9 Aug 2019 at 11:29, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> One way to keep the feature without copy-pasting vmsd would be to add
>> a new vmstate_register with an additional argument to pass the base
>> class vmsd section and handle the whole thing there.
> 
> If we have a vmstate section which contains no actual data,
> only subsections with 'needed' functions, is it migration
> compatible with previous versions in the same way that
> tacking a subsection onto an existing function is?

I don't think so because of the naming schema. I had to forge the
correct name for the reset subsection for every device.
Each subsection must be named after its parent section plus '/something'.

--
Damien

