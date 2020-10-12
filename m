Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B43C2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5uTApjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B43C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS14D-0002lx-H6
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kS11f-0008Fa-O2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kS11c-000055-90
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602521414;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rL7RrLm/BoOE4putQ2aqst09B1X/BUycAMaQ+nfe4Oo=;
 b=h5uTApjtjuCQrNs/cU1yBahDMzHO5AH+EHn5qaoVuuLQJRnuCZfEDH4TM6G0NQQZMJ1rxm
 fhAhGwR6MMsynW2S3drTXofeN9x5eI6ruwpQbRYaotsKlO8VzyiHrRGsWD31au7hF7PElu
 GwV8JnM6B5jkrr6SOcA83sYWmiCMJGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-AwtwUZJOOqaGE5MgmYo-yQ-1; Mon, 12 Oct 2020 12:49:59 -0400
X-MC-Unique: AwtwUZJOOqaGE5MgmYo-yQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CCEC64145;
 Mon, 12 Oct 2020 16:49:57 +0000 (UTC)
Received: from redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 523955D9D2;
 Mon, 12 Oct 2020 16:49:55 +0000 (UTC)
Date: Mon, 12 Oct 2020 17:49:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3] SEV: QMP support for Inject-Launch-Secret
Message-ID: <20201012164952.GK39408@redhat.com>
References: <20200706215451.59179-1-tobin@linux.vnet.ibm.com>
 <20201012161941.GI6677@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201012161941.GI6677@work-vm>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, qemu-devel@nongnu.org,
 Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 05:21:15PM +0100, Dr. David Alan Gilbert wrote:
> * Tobin Feldman-Fitzthum (tobin@linux.vnet.ibm.com) wrote:
> > AMD SEV allows a guest owner to inject a secret blob
> > into the memory of a virtual machine. The secret is
> > encrypted with the SEV Transport Encryption Key and
> > integrity is guaranteed with the Transport Integrity
> > Key. Although QEMU faciliates the injection of the

Trivial typo  s/faciliates/facilitates/

> > launch secret, it cannot access the secret.
> > 
> > Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
> > ---
> >  include/monitor/monitor.h |  3 ++
> >  include/sysemu/sev.h      |  2 ++
> >  monitor/misc.c            |  8 ++---
> >  qapi/misc-target.json     | 18 +++++++++++
> >  target/i386/monitor.c     |  9 ++++++
> >  target/i386/sev-stub.c    |  5 +++
> >  target/i386/sev.c         | 66 +++++++++++++++++++++++++++++++++++++++
> >  target/i386/trace-events  |  1 +
> >  8 files changed, 108 insertions(+), 4 deletions(-)


> > diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> > index dee3b45930..d145f916b3 100644
> > --- a/qapi/misc-target.json
> > +++ b/qapi/misc-target.json
> > @@ -200,6 +200,24 @@
> >  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
> >    'if': 'defined(TARGET_I386)' }
> >  
> > +##
> > +# @sev-inject-launch-secret:
> > +#
> > +# This command injects a secret blob into memory of SEV guest.
> > +#
> > +# @packet-header: the launch secret packet header encoded in base64
> > +#
> > +# @secret: the launch secret data to be injected encoded in base64

Just to double check, this "secret" is /not/ in clear text, so there's
no way either QEMU nor the QMP client can access sensitive info, right ?

If 'secret' was clear text, then we would need to pass the data across
QMP in a different way.

> > +#
> > +# @gpa: the guest physical address where secret will be injected.
> > +#
> > +# Since: 5.1

s/5.1/5.2/

> > +#
> > +##
> > +{ 'command': 'sev-inject-launch-secret',
> > +  'data': { 'packet-header': 'str', 'secret': 'str', 'gpa': 'uint64' },
> > +  'if': 'defined(TARGET_I386)' }
> > +
> >  ##
> >  # @dump-skeys:
> >  #
> > diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> > index 27ebfa3ad2..42bcfe6dc0 100644
> > --- a/target/i386/monitor.c
> > +++ b/target/i386/monitor.c
> > @@ -736,3 +736,12 @@ SevCapability *qmp_query_sev_capabilities(Error **errp)
> >  
> >      return data;
> >  }
> > +
> > +void qmp_sev_inject_launch_secret(const char *packet_hdr,
> > +                                  const char *secret, uint64_t gpa,
> > +                                  Error **errp)
> > +{
> > +    if (sev_inject_launch_secret(packet_hdr, secret, gpa) != 0) {
> > +        error_setg(errp, "SEV inject secret failed");

This generic error message is useless - sev_inject_launch_secret() needs
to take the 'errp' parameter and report what actually failed.

> > +    }
> > +}
> > diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> > index e5ee13309c..fed4588185 100644
> > --- a/target/i386/sev-stub.c
> > +++ b/target/i386/sev-stub.c
> > @@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
> >  {
> >      return NULL;
> >  }
> > +int sev_inject_launch_secret(const char *hdr, const char *secret,
> > +                             uint64_t gpa)
> > +{
> > +    return 1;
> > +}
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index d273174ad3..cbeb8f2e02 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -28,6 +28,8 @@
> >  #include "sysemu/runstate.h"
> >  #include "trace.h"
> >  #include "migration/blocker.h"
> > +#include "exec/address-spaces.h"
> > +#include "monitor/monitor.h"
> >  
> >  #define TYPE_SEV_GUEST "sev-guest"
> >  #define SEV_GUEST(obj)                                          \
> > @@ -769,6 +771,70 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
> >      return 0;
> >  }
> >  
> > +int sev_inject_launch_secret(const char *packet_hdr,
> > +                             const char *secret, uint64_t gpa)
> > +{
> > +    struct kvm_sev_launch_secret input;
> > +    guchar *data = NULL, *hdr = NULL;

If you declare with  'g_autofree' you don't need the manual 'g_free'
calls later. This in turn means you can get rid of the "goto err"
jumps and instead directly return.

> > +    int error, ret = 1;
> > +    void *hva;
> > +    gsize hdr_sz = 0, data_sz = 0;
> > +    Error *local_err = NULL;

Declare with

   g_autoptr(Error) local_err = NULL

to fix the leak David mentions


> > +    MemoryRegion *mr = NULL;
> > +
> > +    /* secret can be inject only in this state */
> > +    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
> > +        error_report("SEV: Not in correct state. (LSECRET) %x",
> > +                     sev_guest->state);
> > +        return 1;
> > +    }
> > +
> > +    hdr = g_base64_decode(packet_hdr, &hdr_sz);
> > +    if (!hdr || !hdr_sz) {
> > +        error_report("SEV: Failed to decode sequence header");
> > +        return 1;
> > +    }
> > +
> > +    data = g_base64_decode(secret, &data_sz);
> > +    if (!data || !data_sz) {
> > +        error_report("SEV: Failed to decode data");
> > +        goto err;
> > +    }
> > +
> > +    hva = gpa2hva(&mr, gpa, data_sz, &local_err);
> > +    if (!hva) {
> > +        error_report("SEV: Failed to calculate guest address.");
> 
> Note this is leaking local_err; you need to turn that into probably an
>   error_reportf_err(local_err, "SEV: Failed to calculate guest address:");

Actually this method needs to take an "Error **errp" parameter, so that the
error is propagated back to the QMP command handler, and from there
back to the client app.

> Also the '5.1' above needs to change to 5.2.
> 
> I think with that it looks OK to me.

> > +        goto err;
> > +    }
> > +
> > +    input.hdr_uaddr = (uint64_t)(unsigned long)hdr;
> > +    input.hdr_len = hdr_sz;
> > +
> > +    input.trans_uaddr = (uint64_t)(unsigned long)data;
> > +    input.trans_len = data_sz;
> > +
> > +    input.guest_uaddr = (uint64_t)(unsigned long)hva;
> > +    input.guest_len = data_sz;
> > +
> > +    trace_kvm_sev_launch_secret(gpa, input.guest_uaddr,
> > +                                input.trans_uaddr, input.trans_len);
> > +
> > +    ret = sev_ioctl(sev_guest->sev_fd, KVM_SEV_LAUNCH_SECRET,
> > +                    &input, &error);
> > +    if (ret) {
> > +        error_report("SEV: failed to inject secret ret=%d fw_error=%d '%s'",
> > +                     ret, error, fw_error_to_str(error));
> > +        goto err;
> > +    }
> > +
> > +    ret = 0;
> > +
> > +err:
> > +    g_free(data);
> > +    g_free(hdr);
> > +    return ret;
> > +}


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


