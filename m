Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B24C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752EB2171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="kI0P18Ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752EB2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw0Jw-0005Vl-O1
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 04:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38499)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hw0JS-0004la-Vq
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hw0JQ-0002IW-Gw
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:31:50 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:47842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hw0JL-0002FZ-V1; Fri, 09 Aug 2019 04:31:44 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id E56C296F50;
 Fri,  9 Aug 2019 08:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1565339501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d89/MwLkkDE59gX8BiGwIUD9xyE3bWVMZLThelBrqw0=;
 b=kI0P18Ow3AsrDNENGsNbKjsOWiAR3EAvCOgctgAdcXCFVCPjkOnZ5lMvkgDHBh2UYbL8uC
 v5gi5OjESI3FLTRExcBfsw0DhkSlFFYztUxPakPoqqHmRY97Kse7DPFYaWpZ59HuW7KpAB
 S7eGb0LPG7IptpRkJ+8DmNhCiCjDBZU=
To: Cornelia Huck <cohuck@redhat.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-15-damien.hedde@greensocs.com>
 <20190808125055.3d4b04bb.cohuck@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <83b94864-c901-a1e1-3bee-aed842250588@greensocs.com>
Date: Fri, 9 Aug 2019 10:31:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808125055.3d4b04bb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1565339501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d89/MwLkkDE59gX8BiGwIUD9xyE3bWVMZLThelBrqw0=;
 b=MgE0lhUPM6BPh6i+QclPJOX8JiT7PJJnGLsVKvEqbEW5JlFVEKOiKX+yTQkDOtIRpNrwys
 XWGh+nEZ+roublx0m2Su10ucOJVFN6FfStgCyd+yzMPuqdk87bkc0jaluKbvxVxAphLPgG
 yYhUECiQeirQ3oMPhiIZj4Ns09V8FIk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1565339501; a=rsa-sha256; cv=none;
 b=3KI6cyl+k4O2gRW9vves9pdAAIoJOj4SEpDbO09Y5mkP/HZH4tYtI3l2WwPs0WJ6pyBs9+
 TZJK5ncKO4HcHWVocrkYZujLhmmOVrUjRJNv1Yb/7A6b+c0ibvk5LjYd9W43BZrQvbXpgm
 zWxZFR2b2dpjFrhm3ag0H+NFDbQNFxs=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 14/33] hw/s390x/s390-virtio-ccw.c:
 remove qdev_reset_all call
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, edgar.iglesias@xilinx.com,
 hare@suse.com, qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, berrange@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/8/19 12:50 PM, Cornelia Huck wrote:
> On Mon, 29 Jul 2019 16:56:35 +0200
> Damien Hedde <damien.hedde@greensocs.com> wrote:
> 
>> Replace deprecated qdev_reset_all by device_reset_warm.
>>
>> This does not impact the behavior.
> 
> Not so sure about that; see below.

In this case, qdev_reset_all is used. The qdev subtree is already reset.
device_reset_* does keep the same children-then-parent call order for
the legacy reset method. This is why the behavior is unchanged.

I will add this point in the commit message of this patch (and also in
other qdev/qbus_reset_all replacement patches) so it will be more clear.

--
Damien

