Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F6420781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAvDw/cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F6420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIZt-00089G-7e
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJIVF-0000fz-3T
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJIVD-00009U-TH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:08:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27268
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJIVD-00009G-OW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585667311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/LNpoz8aWTCoVmYrAr/sG2mvzTcv0QTP8Wo8cAzE0Ts=;
 b=LAvDw/cQ3wP0OdYxJho72wWsIJ6AX7SIgtOnxrCqN/6WD8XJ5jpdozB/7xiNrWOvMC9oyt
 i6h/s4TcNKlBhxfQ45mR3gV96XY9Ryyd+EF9fi0VTXxG9clnKkY7LpTkwZQo+ixkg1Qi1f
 CxF+o95vb4xp149F50PpLbFBGOQhCQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-VHlxT52xPLObpVJM72fh3A-1; Tue, 31 Mar 2020 11:08:29 -0400
X-MC-Unique: VHlxT52xPLObpVJM72fh3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70D3F8024D8;
 Tue, 31 Mar 2020 15:08:28 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E43B6118F49;
 Tue, 31 Mar 2020 15:08:27 +0000 (UTC)
Subject: Re: deprecation of in-tree builds
To: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
 <20200331120220.GA7030@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d447cca0-44b2-392b-3be6-32f17c255dea@redhat.com>
Date: Tue, 31 Mar 2020 10:08:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331120220.GA7030@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 7:02 AM, Kevin Wolf wrote:
> Am 31.03.2020 um 09:48 hat Paolo Bonzini geschrieben:
>> On 30/03/20 16:37, Kevin Wolf wrote:
>>> If manually dealing with separate build directories is inconvenient
>>> today, it will still be inconvenient with Meson, so this would mean
>>> introducing the automatic directly creation together with the other
>>> changes to enable Meson. Which is fine by me, as long as it is really
>>> done when the external directory becomes mandatory, so that people won't
>>> have to switch back and forth between directories.
>>
>> Serious question: why is automatic directly creation more convenient for
>> developers?  Even if "./configure" generates a "build" directory for
>> you, you would still have to invoke the QEMU binary as
>> "build/x86_64-softmmu/qemu-system-x86_64".  That is less convenient than
>> doing "mkdir build" in the first place.
> 
> Mainly because it allows me to start everything (most importantly: my
> editor, git and make) from the same directory.
> 
> I guess the automatic directory creation is the less important part
> compared to a Makefile in the source tree that calls the Makefile in the
> build directory, because creation the directory is a one-time thing, but
> I call make all the time.

If we make in-tree ./configure create a GNUmakefile shim that 
auto-forwards to build/, it would also be possible to create symlinks to 
the various targets that will live in build.  I recently switched my 
qemu playground to use VPATH builds, but with symlinks such as qemu-img 
-> build/qemu-img, I can still use my muscle memory of an in-tree build 
for normal development.

> 
> Creating it automatically is nice especially for those who build QEMU
> for the first time and expect that the ./configure; make; make install
> sequence they are used to just works.
> 
> Prefixing build/ when using the binaries is a change, too, but I guess
> tab completion means that it's not much worse than prefixing ./

With symlinks, it is possible to give much more than 'make' the illusion 
of working in-tree.  It then boils down to a question of how many 
symlinks are worth creating.

> 
>> I can see why it's more convenient for packaging, as they just invoke
>> "make" and "make install", but as far as developers are concerned it
>> seems to add complexity for little or no gain.
> 
> I often use the same terminal for building/testing and git, or sometimes
> even a second editor for source code.
> 
> Kevin
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


