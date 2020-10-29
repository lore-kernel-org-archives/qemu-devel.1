Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078A6C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0542076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcUnzCTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0542076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY6kj-0001wm-5V
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 08:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kY6jm-0001TX-FH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:09:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:36455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kY6jk-0005TW-8w
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:09:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id r10so1203746plx.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XZcUXEYR1pGU/kBjqiNK33tItNrFn5H9WVWH5egvSxQ=;
 b=YcUnzCTiMBA4CEnQq3cnY2RmP2n+FUSzUsQ8vOL6F0Y81YzdfxtU3hwnBmiSOgfHPd
 I2ROv6JVF5/DTe6T4G/1PpIKJB+gOJbRjrDt1yYFE0A1TizMv7Tk4SFywzm+Me5aZr7p
 M7K19S+A3XC6kwqRGJJVSqAHgHFP23mV48mmDLmAX/GIRTfretxRL4q6DPScX/qJ6IyN
 DcRDrMrxrY63WkkmoW2Ax7lkE5qcT6BVeJ6LVfEyCRC64XFxp39KXcg6XB/n5oiOBuGt
 fRJyZ0vmtGg1OBBUCYOUM4vhwoY9lMZvYpxFJx90u7LY6gdbX1VrLk32t9VhrJ/NRQB+
 qfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XZcUXEYR1pGU/kBjqiNK33tItNrFn5H9WVWH5egvSxQ=;
 b=joPaALjHrIVPkDIyjfR5DA3ltmlXsGe5iqV6yNRzbiJHpVl8SR+5jfp3Nms7E5Mutb
 pwJZnCfEPNo3qpU9byarprckRaYiCvTffocaZRi/FW0mygtvfzRZTiW7gbrMN6iAMheH
 us9JQyCYFlVgDBqNK13DsQutSeCLK4nd+HOpz38GTUY4k7AL2+wkLZpPvLAd9G8cSaJG
 QHBMYVvm7XpSbuSODYO35arV+ebpT/dedisjFM8ZAzMulGdFr7ElqmJ4ZbpO4u6uxC54
 4lzjl9EGbyOz4aaM3mBBke0Yc/CUPUqNqqpxCJHCv6mnY3+zqcMbujyYsWLVW0FDCysd
 MxiQ==
X-Gm-Message-State: AOAM531VLRxddm+AYEiC56Sjcp9mY38ZrNBk2C32gkPhd9Tnd11p7gMp
 Iss3isKLfdTh+W2chysbrgmllKZhBin2Vo4uSqo=
X-Google-Smtp-Source: ABdhPJwsP21pvq2MJ3ZjEWdmX4iiCAuhdHFQ+/DcTDbMbew8z8tszCUlExGLs36r8HSftj3WISjjMOT/1Vjon5QP1co=
X-Received: by 2002:a17:902:b90c:b029:d6:868d:f566 with SMTP id
 bf12-20020a170902b90cb02900d6868df566mr3496587plb.2.1603973328848; Thu, 29
 Oct 2020 05:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201027151400.GA138065@stefanha-x1.localdomain>
In-Reply-To: <20201027151400.GA138065@stefanha-x1.localdomain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 29 Oct 2020 12:08:37 +0000
Message-ID: <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Yan Vugenfirer <yan@daynix.com>,
 Jag Raman <jag.raman@oracle.com>, Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here are notes from the session:

protocol stability:
    * vhost-user already exists for existing third-party applications
    * vfio-user is more general but will take more time to develop
    * libvfio-user can be provided to allow device implementations

management:
    * Should QEMU launch device emulation processes?
        * Nicer user experience
        * Technical blockers: forking, hotplug, security is hard once
QEMU has started running
        * Probably requires a new process model with a long-running
QEMU management process proxying QMP requests to the emulator process

migration:
    * dbus-vmstate
    * VFIO live migration ioctls
        * Source device can continue if migration fails
        * Opaque blobs are transferred to destination, destination can
fail migration if it decides the blobs are incompatible
        * How does the VMM share the migration data region with the
device emulation process?
            * The vfio-user protocol can trap or mmap
    * device versioning (like versioned machine types) needed to pin
the guest-visible device ABI
    * Felipe will investigate live migration

reconnection:
    * How to support reconnection?
        * QEMU has relatively little state of a vfio-user device
        * vhost-user has more state so it's a little easier to
reconnect or migrate
    * Build in reconnection and live migration from the start to avoid
difficulties in the future
    * Relationship between migration and reconnection?
        * VFIO has a mechanism for saving/loading device state
        * Lots of different reconnection cases that need to be thought through

security & sandboxing:
    * Goal: make it easy to lock down the process so developers don't
need to reinvent sandboxing
    * minijail
        * in-process
    * firecracker jailer
    * bubblewrap
        * launcher tool
    * systemd-run
        * launcher tool

