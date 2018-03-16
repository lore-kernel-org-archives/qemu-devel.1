Received: from eggs.gnu.org ([2001:4830:134:3::10]:49412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ewqoh-0004sp-UB
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ewqog-0007ZE-OA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:58:48 -0400
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:35093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1ewqog-0007Z1-Ik
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:58:46 -0400
Received: by mail-it0-x22c.google.com with SMTP id v194-v6so2479842itb.0
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 07:58:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152121128086.66.14391574185954997530@71c20359a636>
References: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
	<152121128086.66.14391574185954997530@71c20359a636>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 16 Mar 2018 22:58:45 +0800
Message-ID: <CANRm+CycYFoaB0pgF_43S6hcPoPx9p_boCu8xZxuniHasAGyvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

2018-03-16 22:41 GMT+08:00  <no-reply@patchew.org>:
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 1521211002-4529-1-git-send-email-wanpengli@tencent.com
> Subject: [Qemu-devel] [PATCH] i386/kvm: add support for KVM_CAP_X86_DISABLE_EXITS
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
>
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
>
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
>
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
>
> exit $failed
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/1521211002-4529-1-git-send-email-wanpengli@tencent.com -> patchew/1521211002-4529-1-git-send-email-wanpengli@tencent.com
>  t [tag update]            patchew/20180315034507.6341-1-famz@redhat.com -> patchew/20180315034507.6341-1-famz@redhat.com
> Switched to a new branch 'test'
> 9ababe35bc i386/kvm: add support for KVM_CAP_X86_DISABLE_EXITS
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: i386/kvm: add support for KVM_CAP_X86_DISABLE_EXITS...
> WARNING: line over 80 characters
> #52: FILE: target/i386/kvm.c:1003:
> +        int disable_exits = kvm_check_extension(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS);
>
> ERROR: line over 90 characters
> #58: FILE: target/i386/kvm.c:1009:
> +        if (kvm_vm_enable_cap(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS, 0, disable_exits)) {
>
> total: 1 errors, 1 warnings, 36 lines checked

I think it's fine, otherwise the format looks mess, anyway, please let
me know if they still need to be less than 80 characters here.

Regards,
Wanpeng Li

>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
