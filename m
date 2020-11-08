Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4477C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 08:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037D1206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 08:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICosvDCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037D1206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbgNE-0005Yy-1O
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 03:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kbgMZ-0004xq-9I
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 03:47:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kbgMX-0006qM-SS
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 03:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604825269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+f5vdfgsXGbDy67n1OWHyf9jHjzm/CAGFod47OCSns=;
 b=ICosvDCRCMMLbHyfzbNrwLMdGPo137vFw27iWx1PaL4K1Z5JOEpSJsXxtK2gpHgxqT6EI/
 4iB1J5nmL5JMq96dIB6tr0jCfTjn0TW3zjP034zsgJq6oDXb5+P8weIGbW57qy07EHLNHJ
 3GO8vifDdS8n3RuLElKdRTYc20Lb+yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-rh5Pb33QN--jDSeiNDPXfA-1; Sun, 08 Nov 2020 03:47:45 -0500
X-MC-Unique: rh5Pb33QN--jDSeiNDPXfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 540E2107AFB7;
 Sun,  8 Nov 2020 08:47:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 208965C1D7;
 Sun,  8 Nov 2020 08:47:41 +0000 (UTC)
Subject: Re: [PATCH] macio: set user_creatable to false in macio_class_init()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20201107112811.24870-1-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <70132dc7-8a8c-5cf7-c23f-a8c3a36d63f5@redhat.com>
Date: Sun, 8 Nov 2020 09:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201107112811.24870-1-mark.cave-ayland@ilande.co.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 02:42:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-ppc@nongnu.org,
 armbru@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/11/2020 12.28, Mark Cave-Ayland wrote:
> Commit 348b8d1a76 "macio: don't reference serial_hd() directly within the device"
> removed the setting of user_creatable to false on the basis that the restriction
> was due to the use of serial_hd() in macio_instance_init().
> 
> Unfortunately this isn't the full story since the PIC object property links
> must still be set before the device is realized. Whilst it is possible to update
> the macio device and Mac machines to resolve this, the fix is too invasive at
> this point in the release cycle.
> 
> For now simply set user_creatable back to false in macio_class_init() to
> prevent QEMU from segfaulting in anticipation of the proper fix arriving in
> QEMU 6.0.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/macio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 51368884d0..bb601f782c 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -456,6 +456,8 @@ static void macio_class_init(ObjectClass *klass, void *data)
>      k->class_id = PCI_CLASS_OTHERS << 8;
>      device_class_set_props(dc, macio_properties);
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    /* Reason: requires PIC property links to be set in macio_*_realize() */
> +    dc->user_creatable = false;
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>


