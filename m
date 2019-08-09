Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D74C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE1D2171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="bhbsPiBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE1D2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1VL-0005ce-7C
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hw1Un-0004ZB-7t
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hw1Um-0002Kp-8d
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:47:37 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:50342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hw1Ue-0002Fp-OD; Fri, 09 Aug 2019 05:47:29 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 84A1996F50;
 Fri,  9 Aug 2019 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1565344044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9M1Nz6sxUlKbZ1HX+3au/ichE/NEuolDV2QNeNMOGI=;
 b=bhbsPiBOb5JJx67zFgJcpUPc7IpmkDXLLVHtEf3X2mFvaFcMnrpj9kd70dDTGLYI5n8Mfs
 eHHDtauS68u4r0oMFZ9BHpP/VXQ3Gx15FmXBBy7Re7m2/btNQd2/YPa7VXt1smvI0+nuKP
 1KaE79OdSGsixzJQxhcBXCHa+IM8g5w=
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-13-damien.hedde@greensocs.com>
 <CAFEAcA95fPLh=KgYFgtCxrXR5Vm89-=2fPq-psYYiiJ84j4qvQ@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <6ae5b161-46b4-9587-773b-62485b4b32d1@greensocs.com>
Date: Fri, 9 Aug 2019 11:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95fPLh=KgYFgtCxrXR5Vm89-=2fPq-psYYiiJ84j4qvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1565344044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9M1Nz6sxUlKbZ1HX+3au/ichE/NEuolDV2QNeNMOGI=;
 b=LPnbzZ5kXxChttQ540gN9i/wfcIucjUXhsBAji+Qzsgm0qkXn9BcMJGGYTQ3MKVj83ZL25
 jrYy6ZJ1ohkPWnpQRlqZjApTmIJCw/i0bpc5UlS7s7IHxUbEdd13yUEdOO+XKruB7skhxG
 rO8HOiTq3UJWl/MDENxp9T3MytdPdtw=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1565344044; a=rsa-sha256; cv=none;
 b=TXC5ixYIOu5VjsIyqvXroq70LAYWLs3HG6/Tz9oJu7S7PUPsC3EtZggJiqZDe5yY0ewX+i
 vgs+LAPkQwDjAcrww/rrXWIhiUQP4iA5X3VTKoMgXulg+CUVLdHMere/oMvfAWK3yG/dt0
 p2vStFJ/vJFlOj0IXUGxw5bBKUExRsE=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 12/33] hw/pci/: remove
 qdev/qbus_reset_all call
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
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/7/19 5:31 PM, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Replace deprecated qdev/bus_reset_all by device/bus_reset_warm.
>>
>> This does not impact the behavior.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> 
> I'll come back to patches 12-28 later. They're all ok
> in principle, we just need to check that in each individual
> case:
>  * we've made the right choice of cold vs warm reset
>  * we're ok to switch to 'reset including children' from
>    the legacy 'reset not including children' semantics

I'm working on a patch reroll to fix what's been reviewed so far. Should
I put aside the patches 12-28 for now ? They could be part of 1 or 2
separate following series or I can re-add them later on when we agree on
the api.

--
Damien

