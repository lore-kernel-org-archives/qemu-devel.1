Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489E9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 19:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6EE20756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyxAaIhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6EE20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Zef-0004zS-0U
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 15:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5Zdw-0004R4-Jx
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 15:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5Zds-0003ox-SX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 15:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597172938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weJx/XapsbMy4PKLwOT+gVyRmvhDfXP69FFqUj9jmeM=;
 b=FyxAaIhcGcL9NgSGUxYdHAJLbXQttRkCtg+8h5+a02/cKBXWA6ilpmUZ+Z3pEfeCRhY8KD
 FNqNsLA6GhlPPjwt3ACgQ08Fe1XPXMAG/C38Q/Jri5HC+EtX0OazMPpXzIne72WC5vSmGw
 RZ+w1EGr1n2ogMvE/aGtXCF3DVCf+g8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-9DqUgzu0PQCrZ2XhCb3gaQ-1; Tue, 11 Aug 2020 15:08:47 -0400
X-MC-Unique: 9DqUgzu0PQCrZ2XhCb3gaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC23879EC0;
 Tue, 11 Aug 2020 19:08:46 +0000 (UTC)
Received: from work-vm (ovpn-113-252.ams2.redhat.com [10.36.113.252])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B133B1002388;
 Tue, 11 Aug 2020 19:08:32 +0000 (UTC)
Date: Tue, 11 Aug 2020 20:08:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH V1 00/32] Live Update
Message-ID: <20200811190830.GQ2671@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <20200730165249.GR3477223@redhat.com>
 <aa6940d9-7c2a-bdc2-edaf-ea4fea56e61f@oracle.com>
 <20200731085349.GB3518939@redhat.com>
 <dcb66c6b-cb2a-1848-d83b-2dc27be400f3@oracle.com>
 <20200731155252.GE3660103@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200731155252.GE3660103@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 05:47:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steven Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Fri, Jul 31, 2020 at 11:27:45AM -0400, Steven Sistare wrote:
> > On 7/31/2020 4:53 AM, Daniel P. Berrangé wrote:
> > > On Thu, Jul 30, 2020 at 02:48:44PM -0400, Steven Sistare wrote:
> > >> On 7/30/2020 12:52 PM, Daniel P. Berrangé wrote:
> > >>> On Thu, Jul 30, 2020 at 08:14:04AM -0700, Steve Sistare wrote:
> > >>>> Improve and extend the qemu functions that save and restore VM state so a
> > >>>> guest may be suspended and resumed with minimal pause time.  qemu may be
> > >>>> updated to a new version in between.
> > >>>>
> > >>>> The first set of patches adds the cprsave and cprload commands to save and
> > >>>> restore VM state, and allow the host kernel to be updated and rebooted in
> > >>>> between.  The VM must create guest RAM in a persistent shared memory file,
> > >>>> such as /dev/dax0.0 or persistant /dev/shm PKRAM as proposed in 
> > >>>> https://lore.kernel.org/lkml/1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com/
> > >>>>
> > >>>> cprsave stops the VCPUs and saves VM device state in a simple file, and
> > >>>> thus supports any type of guest image and block device.  The caller must
> > >>>> not modify the VM's block devices between cprsave and cprload.
> > >>>>
> > >>>> cprsave and cprload support guests with vfio devices if the caller first
> > >>>> suspends the guest by issuing guest-suspend-ram to the qemu guest agent.
> > >>>> The guest drivers suspend methods flush outstanding requests and re-
> > >>>> initialize the devices, and thus there is no device state to save and
> > >>>> restore.
> > >>>>
> > >>>>    1 savevm: add vmstate handler iterators
> > >>>>    2 savevm: VM handlers mode mask
> > >>>>    3 savevm: QMP command for cprsave
> > >>>>    4 savevm: HMP Command for cprsave
> > >>>>    5 savevm: QMP command for cprload
> > >>>>    6 savevm: HMP Command for cprload
> > >>>>    7 savevm: QMP command for cprinfo
> > >>>>    8 savevm: HMP command for cprinfo
> > >>>>    9 savevm: prevent cprsave if memory is volatile
> > >>>>   10 kvmclock: restore paused KVM clock
> > >>>>   11 cpu: disable ticks when suspended
> > >>>>   12 vl: pause option
> > >>>>   13 gdbstub: gdb support for suspended state
> > >>>>
> > >>>> The next patches add a restart method that eliminates the persistent memory
> > >>>> constraint, and allows qemu to be updated across the restart, but does not
> > >>>> allow host reboot.  Anonymous memory segments used by the guest are
> > >>>> preserved across a re-exec of qemu, mapped at the same VA, via a proposed
> > >>>> madvise(MADV_DOEXEC) option in the Linux kernel.  See
> > >>>> https://lore.kernel.org/lkml/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/
> > >>>>
> > >>>>   14 savevm: VMS_RESTART and cprsave restart
> > >>>>   15 vl: QEMU_START_FREEZE env var
> > >>>>   16 oslib: add qemu_clr_cloexec
> > >>>>   17 util: env var helpers
> > >>>>   18 osdep: import MADV_DOEXEC
> > >>>>   19 memory: ram_block_add cosmetic changes
> > >>>>   20 vl: add helper to request re-exec
> > >>>>   21 exec, memory: exec(3) to restart
> > >>>>   22 char: qio_channel_socket_accept reuse fd
> > >>>>   23 char: save/restore chardev socket fds
> > >>>>   24 ui: save/restore vnc socket fds
> > >>>>   25 char: save/restore chardev pty fds
> > >>>
> > >>> Keeping FDs open across re-exec is a nice trick, but how are you dealing
> > >>> with the state associated with them, most especially the TLS encryption
> > >>> state ? AFAIK, there's no way to serialize/deserialize the TLS state that
> > >>> GNUTLS maintains, and the patches don't show any sign of dealing with
> > >>> this. IOW it looks like while the FD will be preserved, any TLS session
> > >>> running on it will fail.
> > >>
> > >> I had not considered TLS.  If a non-qemu library maintains connection state, then
> > >> we won't be able to support it for live update until the library provides interfaces
> > >> to serialize the state.
> > >>
> > >> For qemu objects, so far vmstate has been adequate to represent the devices with
> > >> descriptors that we preserve.
> > > 
> > > My main concern about this series is that there is an implicit assumption
> > > that QEMU is *not* configured with certain features that are not handled
> > > If QEMU is using one of the unsupported features, I don't see anything in
> > > the series which attempts to prevent the actions.
> > > 
> > > IOW, users can have an arbitrary QEMU config, attempt to use these new features,
> > > the commands may well succeed, but the user is silently left with a broken QEMU.
> > > Such silent failure modes are really undesirable as they'll lead to a never
> > > ending stream of hard to diagnose bug reports for QEMU maintainers.
> > > 
> > > TLS is one example of this, the live upgrade  will "succeed", but the TLS
> > > connections will be totally non-functional.
> > 
> > I agree with all your points and would like to do better in this area.  Other than hunting for 
> > every use of a descriptor and either supporting it or blocking cpr, do you have any suggestions?
> > Thinking out loud, maybe we can gather all the fds that we support, then look for all fds in the
> > process, and block the cpr if we find an unrecognized fd.
> 
> There's no magic easy answer to this problem. Conceptually it is similar to
> the problem of reliably migrating guest device state, but in this case we're
> primarily concerned about the backends instead.
> 
> For migration we've got standardized interfaces that devices must implement
> in order to correctly support migration serialization. There is also support
> for devices to register migration "blockers" which prevent any use of the
> migration feature when the device is present.
> 
> We lack this kind of concept for the backend, and that's what I think needs
> to be tackled in a more thorough way.  There are quite alot of backends,
> but they're grouped into a reasonable small number of sets (UIs, chardevs,
> blockdevs, net devs, etc). We need some standard interface that we can
> plumb into all the backends, along with providing backends the ability to
> block the re-exec. If we plumb the generic infrastructure into each of the
> different types of backend, and make the default behaviour be to reject
> the re-exec. Then we need to carefull consider specific  backend impls
> and allow the re-exec only in the very precise cases we can demonstrate
> to be safe.
> 
> IOW, have a presumption that re-exec will *not* be permitted. Over time
> we can make it work for an ever expanding set of use cases. 

Yes, it does feel like an interface that needs to be implemented on the
chardev; then you don't need to worry about handling them all
individually.

Dave

> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


