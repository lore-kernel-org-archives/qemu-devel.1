Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FCCC742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158E72166E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158E72166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltrw-0005ec-6g
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52716)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hltrm-0005Gt-Ty
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hltrl-0002hH-P7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:37:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hltrj-0002ds-Tg
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:37:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF4E530C34C8;
 Fri, 12 Jul 2019 11:37:25 +0000 (UTC)
Received: from work-vm (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41A82611C3;
 Fri, 12 Jul 2019 11:37:24 +0000 (UTC)
Date: Fri, 12 Jul 2019 12:37:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190712113721.GG2730@work-vm>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-14-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710202219.25939-14-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 12 Jul 2019 11:37:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 13/13] target/i386: sev: remove
 migration blocker
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

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  target/i386/sev.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 93c6a90806..48336515a2 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -34,7 +34,6 @@
>  #define DEFAULT_SEV_DEVICE      "/dev/sev"
>  
>  static SEVState *sev_state;
> -static Error *sev_mig_blocker;
>  
>  static const char *const sev_fw_errlist[] = {
>      "",
> @@ -686,7 +685,6 @@ static void
>  sev_launch_finish(SEVState *s)
>  {
>      int ret, error;
> -    Error *local_err = NULL;
>  
>      trace_kvm_sev_launch_finish();
>      ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
> @@ -697,16 +695,6 @@ sev_launch_finish(SEVState *s)
>      }
>  
>      sev_set_guest_state(SEV_STATE_RUNNING);
> -
> -    /* add migration blocker */
> -    error_setg(&sev_mig_blocker,
> -               "SEV: Migration is not implemented");
> -    ret = migrate_add_blocker(sev_mig_blocker, &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -        error_free(sev_mig_blocker);
> -        exit(1);
> -    }
>  }
>  
>  static int
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

