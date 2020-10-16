Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C122BC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4FB207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5+mJAlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4FB207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSCq-0005U6-Qi
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kTSB9-0003tv-8Z
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:02:03 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kTSB7-00060Y-7U
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:02:02 -0400
Received: by mail-lj1-x244.google.com with SMTP id m16so3035976ljo.6
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cIjxEXi6/1Ci8HAZ985Gw92uP+12htILEakXToNiOhE=;
 b=E5+mJAlEFFRHn0PU1cWH2W8SIGpD5Eb5gb18yAkdIvqMPEAhLMThWiSU9xHFkUgYlr
 1juAUTeSJmWgjQpz7CmH9HA/cpDbEj4cyAKqFbPBkjJzzqHrp3M15Q0PlKdTPHtAAZ8x
 qPN4Tlhumd8wik+mOGPkpddWbra3MnoF4th1OmpWgBsqfAKhi3yYF/OtVbnC+JveaPBj
 M8oUE1DiOiZpIRjAX+zPeLqu6nJ/nkj5sCWFsTVVD1/2S+cOhh2uD0t/QaxwHGsB3Iu5
 Ge7qNMjZtGMaGtXRbBlfJo7G47jMSGyJ/qTxoo8iv+VB3wF1WUk6tf/QgL2LwSDkpwUK
 wIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cIjxEXi6/1Ci8HAZ985Gw92uP+12htILEakXToNiOhE=;
 b=VYKwvkrvrUplIkg5JvXeQhzMQHbMeS3Koz5y570AGzX2rsZx+HcpFXnxzVVsECm5hJ
 FUkpoZmpiVSQeL89PUbsdzOPp9A3t5wxB7ZYQPfmIc95X2LxF5lXFHPLM+Dlmx0rLugC
 ZzDT/hWQkI00NkGKgkQaviHnnjA4sYIcmglxKfStxWqf2b6VBhOUprzSCUX5N4F1pOsd
 o+vDreUyZFsc6d97ItKcXQygC1nwwpGEqW9XvQBqcMThqrnQBNgMQ0OVQKGuVCjieWxu
 pnBjwbXqHgnKL1eY0De5Phg6mGlC3LUoQP+DmujkFFNm0/1VOQxAMWbBllnZRQtYeVBR
 SJQw==
X-Gm-Message-State: AOAM530qQu6XSW5wpSdc6vUKmevruyviBq+0+iYfcOP65LNaGN5Vvy5M
 xO2SpGPBM4k5+LAmZmZUwpmKv9EO1Fzom4zcRS0=
X-Google-Smtp-Source: ABdhPJzIMzwsUUc/O+9gITsdj67uq8SXf6e4S58oij+r74HezAGqEHNkHgyPbrj7SW5anw+QvlgpBGfQnlwH/m0ONoM=
X-Received: by 2002:a2e:96d2:: with SMTP id d18mr1777036ljj.407.1602864118597; 
 Fri, 16 Oct 2020 09:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201013190506.3325-1-jandryuk@gmail.com>
 <20201016153708.GB3105841@perard.uk.xensource.com>
In-Reply-To: <20201016153708.GB3105841@perard.uk.xensource.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Fri, 16 Oct 2020 12:01:47 -0400
Message-ID: <CAKf6xpssB-FGwiEhLqV8OFjBGuP4LKYh+9Pj_Bj7p5U2CJSw=g@mail.gmail.com>
Subject: Re: [PATCH] hw/xen: Set suppress-vmdesc for Xen machines
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x244.google.com
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 11:38 AM Anthony PERARD
<anthony.perard@citrix.com> wrote:
>
> On Tue, Oct 13, 2020 at 03:05:06PM -0400, Jason Andryuk wrote:
> > xen-save-devices-state doesn't currently generate a vmdesc, so restore
> > always triggers "Expected vmdescription section, but got 0".  This is
> > not a problem when restore comes from a file.  However, when QEMU runs
> > in a linux stubdom and comes over a console, EOF is not received.  This
> > causes a delay restoring - though it does restore.
> >
> > Setting suppress-vmdesc skips looking for the vmdesc during restore and
> > avoids the wait.
>
> suppress-vmdesc is only used during restore, right? So starting a guest
> without it, saving the guest and restoring the guest with
> suppress-vmdesc=on added will work as intended? (I'm checking that migration
> across update of QEMU will work.)

vmdesc is a json description of the migration stream that comes after
the QEMU migration stream.  For our purposes, <migration
stream><vmdesc json blob>.  Normal QEMU savevm will generate it,
unless suppress-vmdesc is set.  QEMU restore will read it because:
"Try to read in the VMDESC section as well, so that dumping tools that
intercept our migration stream have the chance to see it."

Xen save does not go through savevm, but instead
xen-save-devices-state, which is a subset of the QEMU savevm.  It
skips RAM since that is read out through Xen interfaces.  Xen uses
xen-load-devices-state to restore device state.  That goes through the
common qemu_loadvm_state which tries to read the vmdesc stream.

For Xen, yes, suppress-vmdesc only matters for the restore case, and
it suppresses the attempt to read the vmdesc.  I think every Xen
restore currently has "Expected vmdescription section, but got -1" in
the -dm.log since the vmdesc is missing.  I have not tested restoring
across this change, but since it just controls reading and discarding
the vmdesc stream, I don't think it will break migration across
update.

Regards,
Jason

