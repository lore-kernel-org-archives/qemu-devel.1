Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D7EC4CED1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C49420862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C49420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMpo-0005U8-BZ
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iGMoq-0004jF-3N
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iGMoo-0000KT-Ke
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:36:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iGMoo-0000KA-Cp
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C3BB10C095A;
 Fri,  4 Oct 2019 12:36:21 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9369C5C21A;
 Fri,  4 Oct 2019 12:36:16 +0000 (UTC)
Date: Fri, 4 Oct 2019 13:36:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: libvirt? qemu change that mmaps ELF files breaks libvirt svirt
 handling for os.kernel
Message-ID: <20191004123613.GF25716@redhat.com>
References: <d450afbe-06ae-f6f7-3bc0-f1a54c31907c@de.ibm.com>
 <1dc0a320-b771-072d-d1f4-4eda2ab51a1f@redhat.com>
 <a12ee0e1-44cc-e197-68e3-4a7137c8b972@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a12ee0e1-44cc-e197-68e3-4a7137c8b972@de.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 04 Oct 2019 12:36:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Libvirt <libvir-list@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 04, 2019 at 02:18:49PM +0200, Christian Borntraeger wrote:
> 
> 
> On 04.10.19 14:13, Paolo Bonzini wrote:
> > On 04/10/19 14:03, Christian Borntraeger wrote:
> >> Stefano, Paolo,
> >>
> >> I have an interesting fail in QEMU 
> >>
> >> 2019-10-04T12:00:32.675188Z qemu-system-s390x: GLib: g_mapped_file_unref: assertion 'file != NULL' failed
> >> that bisected to 
> >> commit 816b9fe450220e19acb91a0ce4a8ade7000648d1 (refs/bisect/bad)
> >>     elf-ops.h: Map into memory the ELF to load
> >>
> >> strace tells that I can read the ELF file, but not mmap
> >> strace:
> >> 214365 openat(AT_FDCWD, "/var/lib/libvirt/images/test_cpu_timer.elf", O_RDONLY) = 36
> >> 214365 read(46, "\177ELF\2\2\1\0\0\0\0\0\0\0\0\0", 16) = 16
> >> 214365 lseek(46, 0, SEEK_SET)           = 0
> >> [...]
> >> 214365 fstat(46, {st_mode=S_IFREG|0755, st_size=168176, ...}) = 0
> >> 214365 mmap(NULL, 168176, PROT_READ|PROT_WRITE, MAP_PRIVATE, 46, 0) = -1 EACCES (Permission denied)
> >>
> >> So reading from /var/lib/libvirt/images/test_cpu_timer.elf does work, mmaping does not.
> >> setenforce 0 makes the problem go away. 
> >>
> >> This might be more of an issue in libvirt, setting the svirt context too
> >> restrictive, but I am not too deep into the svirt part of libvirt.
> >> Reverting the qemu commit makes the problem go away.
> > 
> > Yes, the policy is too restrictive in my opinion.
> > 
> > Can you include the output of "audit2allow" and/or "audit2allow -R"?
> > 
> > Thanks,
> > 
> > Paolo
> > 
> 
> require {
> 	type unconfined_t;
> 	type virt_content_t;
> 	type svirt_t;
> 	type systemd_tmpfiles_t;
> 	type user_home_t;
> 	type NetworkManager_t;
> 	class file { entrypoint execute ioctl lock map open read write };
> 	class bpf prog_run;
> }
> 
> #============= svirt_t ==============
> allow svirt_t user_home_t:file { entrypoint execute ioctl lock open read write };
> 
> #!!!! This avc can be allowed using the boolean 'domain_can_mmap_files'

This is an unrelated boolean and we don't want to use that so ignore
this suggestion !

> allow svirt_t virt_content_t:file map;

This matches your strace.  virt_content_t is the label we use on
files that are exposed to QEMU read-only.

The svirt policy only allows mmap on files that re exposed read-write
currently.

I believe we can safely allow this mmap on read-only files too
because  the read-only restriction is enforced at time of open,
and any writes to the mapped file  will result in a private
copy on write.

Please file a bz entry against the selinux-policy component for
whatever distro you're using, and/or Fedora rawhide, and CC me
on it too.

> corecmd_bin_entry_type(svirt_t)
> userdom_manage_user_home_content_dirs(svirt_t)
> userdom_map_user_home_files(svirt_t)
> virt_rw_svirt_image(svirt_t)

These look unrelated to the problem above.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

