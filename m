Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4773BC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109A420835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="beR1D8bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109A420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQui-0007fs-HG
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iCQsZ-0006Q9-Ir
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iCQsW-0000SV-1u
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:07:59 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:42822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iCQsV-0000LX-PQ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569254875;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kYTPq/m6mJCnPR7CzZJFQy2xo0zfrgZrJFhqDjT/k8Y=;
 b=beR1D8bxa/lSpc2GwtVs1yvQNOcXW8KPHmagjvAxItf0KVG+NNpS9aGE
 ccSmhpHLVFtNDDt/MklAMxPU7lP5ZU5XTU0e8VYU1rSWzSAPU4cTKTVLV
 DKWtoYuNaPoV1vFWWFWXEjmDNan8puTDTBnXbjB1+a1gDP1nHtJc741NO s=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 2BFSpX+i73kp32ExYqoDKlY6D6EFe7b5FXPqnOQsUMsxW4kjD5YG4T2ggHH1Psxz/sUFZMUNm2
 3PPusrciR3Kpk19s1Nhvuuv41z0Wc7vMajdAZWiN2/P1PJPYMorFrfhTKcb/I1uW2GmvHZNe2w
 V/Op37tShBGEzGqyzGKtwQcjvWmG3jbTR0wSpleja4MbpkzyGnUL+IIx1uhPFC5eioopLgGo0s
 8rEE6NabbO1TjEej58wNEwfsncD7m5SfOzc7U2nkM0101hMc55OAaUUmQJ6FB+WcOAXZk6HoQu
 TCY=
X-SBRS: 2.7
X-MesageID: 6208294
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,541,1559534400"; 
   d="scan'208";a="6208294"
Date: Mon, 23 Sep 2019 17:07:51 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v3] ui: add an embedded Barrier client
Message-ID: <20190923160751.GA212017@perard.uk.xensource.com>
References: <20190906083812.29487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190906083812.29487-1-laurent@vivier.eu>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Once this patch is applied, if we try to start QEMU with "-k en-us",
qemu print a message and exit:
    qemu-system-i386: could not read keymap file: 'en-us'

See below,

On Fri, Sep 06, 2019 at 10:38:12AM +0200, Laurent Vivier wrote:
> diff --git a/ui/input-barrier.c b/ui/input-barrier.c
> new file mode 100644
> index 000000000000..a2c961f285a4
> --- /dev/null
> +++ b/ui/input-barrier.c
> +static void input_barrier_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> +
> +    ucc->complete = input_barrier_complete;
> +
> +    /* always use generic keymaps */
> +    if (keyboard_layout) {
> +        /* We use X11 key id, so use VNC name2keysym */
> +        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
> +                                          &error_fatal);

I think it's because this function is called way to early, before
qemu_add_data_dir() is called, and so qemu_find_file() fails.

Can you fix it?

Thanks.

> +    }
> +}
> +
> +static const TypeInfo input_barrier_info = {
> +    .name = TYPE_INPUT_BARRIER,
> +    .parent = TYPE_OBJECT,
> +    .class_size = sizeof(InputBarrierClass),
> +    .class_init = input_barrier_class_init,
> +    .instance_size = sizeof(InputBarrier),
> +    .instance_init = input_barrier_instance_init,
> +    .instance_finalize = input_barrier_instance_finalize,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&input_barrier_info);
> +}
> +
> +type_init(register_types);

-- 
Anthony PERARD

