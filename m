Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722BCC742C2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485A8206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485A8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwYj-0000WT-7m
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44123)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlwYZ-000083-OU
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlwYY-0008K8-KR
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:29:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlwYY-0008Ha-By
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:29:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B459D81F0E;
 Fri, 12 Jul 2019 14:29:47 +0000 (UTC)
Received: from work-vm (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CC9E5C559;
 Fri, 12 Jul 2019 14:29:45 +0000 (UTC)
Date: Fri, 12 Jul 2019 15:29:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190712142942.GL2730@work-vm>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-7-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710202219.25939-7-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 12 Jul 2019 14:29:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/13] doc: update AMD SEV to include
 Live migration flow
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Singh, Brijesh (brijesh.singh@amd.com) wrote:
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  docs/amd-memory-encryption.txt | 42 +++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
> index abb9a976f5..374f4b0a94 100644
> --- a/docs/amd-memory-encryption.txt
> +++ b/docs/amd-memory-encryption.txt
> @@ -89,7 +89,47 @@ TODO
>  
>  Live Migration
>  ----------------
> -TODO
> +AMD SEV encrypts the memory of VMs and because a different key is used
> +in each VM, the hypervisor will be unable to simply copy the
> +ciphertext from one VM to another to migrate the VM. Instead the AMD SEV Key
> +Management API provides sets of function which the hypervisor can use
> +to package a guest page for migration, while maintaining the confidentiality
> +provided by AMD SEV.
> +
> +SEV guest VMs have the concept of private and shared memory. The private
> +memory is encrypted with the guest-specific key, while shared memory may
> +be encrypted with the hypervisor key. The migration APIs provided by the
> +SEV API spec should be used for migrating the private pages. The
> +KVM_GET_PAGE_ENC_BITMAP ioctl can be used to get the guest page encryption
> +bitmap. The bitmap can be used to check if the given guest page is
> +private or shared.
> +
> +Before initiating the migration, we need to know the targets machine's public
> +Diffie-Hellman key (PDH) and certificate chain. It can be retrieved
> +with the 'query-sev-capabilities' QMP command or using the sev-tool. The
> +migrate-set-sev-info object can be used to pass the target machine's PDH and
> +certificate chain.
> +
> +e.g
> +(QMP) migrate-sev-set-info pdh=<target_pdh> plat-cert=<target_cert_chain> \
> +       amd-cert=<amd_cert>
> +(QMP) migrate tcp:0:4444
> +
> +
> +During the migration flow, the SEND_START is called on the source hypervisor
> +to create outgoing encryption context. The SEV guest policy dectates whether
            ^an outgoing                                       ^ d*i*ctates

> +the certificate passed through the migrate-sev-set-info command will be
> +validate. SEND_UPDATE_DATA is called to encrypt the guest private pages.
          ^ validate*d* ?  How does the cert get validated anyway? As a
guest owner what rules can I set about which other host it gets migrated
to?

Actually, thinking about it, I didn't notice anything in the patchset
that checked/gave diagnostics about the guest policy - shouldn't there
be something that nicely says something like:
  'Guest policy has NOSEND set, guest can not be migrated'

?

> +After migration is completed, SEND_FINISH is called to destroy the encryption
> +context and make the VM non-runnable to protect it against the cloning.
                                                              ^ 'the' not needed
> +
> +On the target machine, RECEIVE_START is called first to create an
> +incoming encryption context. The RECEIVE_UPDATE_DATA is called to copy
> +the receieved encrypted page into guest memory. After migration has
> +completed, RECEIVE_FINISH is called to make the VM runnable.
> +
> +For more information about the migration see SEV API Appendix A
> +Usage flow (Live migration section).
>  
>  References
>  -----------------
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

