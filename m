Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BC0C55186
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE820206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsTzfoCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE820206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSI4f-0006fX-W3
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 06:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSI3y-00068U-O9
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSI3x-0003Av-7k
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:29:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jSI3w-0003Aj-Oa
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587810571;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=Q/xkfiGrU7hh4/L5+3uvml1/PEXlx9XSGF3Y52m3IPs=;
 b=hsTzfoCy10r8mkCTpjdpVvkiYumfAX5Qb209EHPa2UbrUO2hZ3w379HU3CKVfL1SMxse5i
 D0wt7ncEwL/9S+a4oejcANc4Zqx/R4xjRHHu/AZsP8sOkBGqzi1UYx2A92YwDf4Ph7HdjH
 IljVJ/sw2RVtT0xnKg/aFs0/k+GZAnA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-UUEe3CmHPDWmE7drGNPStA-1; Sat, 25 Apr 2020 06:29:26 -0400
X-MC-Unique: UUEe3CmHPDWmE7drGNPStA-1
Received: by mail-wr1-f71.google.com with SMTP id f2so6520936wrm.9
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 03:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:reply-to:subject:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=Wtc798SaiZRKd4xvI15KW6Lm5IMWQxOD5VKCV+R0GjA=;
 b=qCIFL7UkG25dk57cy67LaQDywW/lKY9s2KhMD5tmZMxUg3g6fS/+yZNaZkkj0+GDgo
 umuxqy1PXLcPuZ4AZ84NkYqoGJ3g86A7AI7RolLMZ0rjcNYYslEXsau9HeeoT1LsCcy2
 nhkcm3zUPDQZTYDh7CeBzS4uhn++5/2Q1ItqI9wSe2x7FPyL57+3YzT3XQ6r5XLgc4H/
 AENF3nLUTY7xmn61CToFxn05p08Y15hIPkCSKARB/T8TR2oh0ZC9rJCXI2EyvQIntmFf
 8RYAELjpKyk1aXZKVKpe1sKPrK+bG+8b+a+nwkJ7IU2KDhg2XkR0q0Ro3ksq3UXeihf+
 kTdQ==
X-Gm-Message-State: AGi0PuY8UlNkbH5j/vV1hk61m8mNbx61t6GZtwfT8wQ7X/UmDZe4gSrw
 hYSPCBDkK5/P3luZBlfLrxUytT0ECBIcbQZl8E8HP0XyQO6apquguUvucxNei65qc9BMG7ZmRzf
 XPTgN7eGnG/lZppk=
X-Received: by 2002:a5d:6b8a:: with SMTP id n10mr16036961wrx.36.1587810565330; 
 Sat, 25 Apr 2020 03:29:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypKrXXpKyRrBQw9KkMlM/i2jcGT9lAiH2FwZ8dFH+eCYZgK0PBopf1xo9ue/6znHXT3G3NYTtA==
X-Received: by 2002:a5d:6b8a:: with SMTP id n10mr16036938wrx.36.1587810564943; 
 Sat, 25 Apr 2020 03:29:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926?
 ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
 by smtp.gmail.com with ESMTPSA id v1sm12516300wrv.19.2020.04.25.03.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2020 03:29:24 -0700 (PDT)
To: qemu-devel <qemu-devel@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 KVM list <kvm@vger.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: CFP: KVM Forum 2020
Message-ID: <a1d960aa-c1a0-ff95-68a8-6e471028fe1e@redhat.com>
Date: Sat, 25 Apr 2020 12:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 06:29:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Reply-To: kvm-forum-2020-pc@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
KVM Forum 2020: Call For Participation
October 28-30, 2020 - Convention Centre Dublin - Dublin, Ireland

(All submissions must be received before June 15, 2020 at 23:59 PST)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

KVM Forum is an annual event that presents a rare opportunity for
developers and users to meet, discuss the state of Linux virtualization
technology, and plan for the challenges ahead. This highly technical
conference unites the developers who drive KVM development and the users
who depend on KVM as part of their offerings, or to power their data
centers and clouds.

Sessions include updates on the state of the KVM virtualization stack,
planning for the future, and many opportunities for attendees to
collaborate. After more than ten years in the mainline kernel, KVM
continues to be a critical part of the FOSS cloud infrastructure. Come
join us in continuing to improve the KVM ecosystem.

We understand that these are uncertain times and we are continuously
monitoring the COVID-19/Novel Coronavirus situation. Our attendees'
safety is of the utmost importance. If we feel it is not safe to meet in
person, we will turn the event into a virtual experience. We hope to
announce this at the same time as the speaker notification. Speakers
will still be expected to attend if a physical event goes ahead, but we
understand that exceptional circumstances might arise after speakers are
accepted and we will do our best to accommodate such circumstances.

Based on these factors, we encourage you to submit and reach out to us
should you have any questions. The program committee may be contacted as
a group via email: kvm-forum-2020-pc@redhat.com.


SUGGESTED TOPICS
----------------

* Scaling, latency optimizations, performance tuning
* Hardening and security
* New features
* Testing

KVM and the Linux Kernel:
* Nested virtualization
* Resource management (CPU, I/O, memory) and scheduling
* VFIO: IOMMU, SR-IOV, virtual GPU, etc.
* Networking: Open vSwitch, XDP, etc.
* virtio and vhost
* Architecture ports and new processor features

QEMU:
* Management interfaces: QOM and QMP
* New devices, new boards, new architectures
* New storage features
* High availability, live migration and fault tolerance
* Emulation and TCG
* Firmware: ACPI, UEFI, coreboot, U-Boot, etc.

Management & Infrastructure
* Managing KVM: Libvirt, OpenStack, oVirt, KubeVirt, etc.
* Storage: Ceph, Gluster, SPDK, etc.
* Network Function Virtualization: DPDK, OPNFV, OVN, etc.
* Provisioning


SUBMITTING YOUR PROPOSAL
------------------------

Abstracts due: June 15, 2020

Please submit a short abstract (~150 words) describing your presentation
proposal. Slots vary in length up to 45 minutes.

Submit your proposal here:
https://events.linuxfoundation.org/kvm-forum/program/cfp/

Please only use the categories "presentation" and "panel discussion"

You will receive a notification whether or not your presentation
proposal was accepted by August 17, 2020.

Speakers will receive a complimentary pass for the event. In case your
submission has multiple presenters, only the primary speaker for a
proposal will receive a complimentary event pass. For panel discussions,
all panelists will receive a complimentary event pass.


TECHNICAL TALKS

A good technical talk should not just report on what has happened over
the last year; it should present a concrete problem and how it impacts
the user and/or developer community. Whenever applicable, focus on work
that needs to be done, difficulties that haven't yet been solved, and on
decisions that other developers should be aware of. Summarizing recent
developments is okay but it should not be more than a small portion of
the overall talk.


END-USER TALKS

One of the big challenges as developers is to know what, where and how
people actually use our software. We will reserve a few slots for end
users talking about their deployment challenges and achievements.

If you are using KVM in production you are encouraged submit a speaking
proposal. Simply mark it as an end-user talk. As an end user, this is a
unique opportunity to get your input to developers.


PANEL DISCUSSIONS

If you are proposing a panel discussion, please make sure that you list
all of your potential panelists in your the abstract. We will request
full biographies if a panel is accepted.


HANDS-ON / BOF SESSIONS

We will reserve some time for people to get together and discuss
strategic decisions as well as other topics that are best solved within
smaller groups.

These sessions will be announced during the event. If you are interested
in organizing such a session, please add it to the list at

  http://www.linux-kvm.org/page/KVM_Forum_2020_BOF

Let people you think who might be interested know about your BOF, and
encourage them to add their names to the wiki page as well. Please add
your ideas to the list before KVM Forum starts.


HOTEL / TRAVEL
--------------

This year's event will take place at the Conference Center Dublin. For
information on hotels close to the conference, please visit
https://events.linuxfoundation.org/kvm-forum/attend/venue-travel/.
Information on conference hotel blocks will be available later in
Spring 2020.


DATES TO REMEMBER
-----------------

* CFP Opens: Monday, April 27, 2020
* CFP Closes: Monday, June 15 at 11:59 PM PST
* CFP Notifications: Monday, August 17
* Schedule Announcement: Thursday, August 20
* Slide Due Date: Monday, October 26
* Event Dates: Wednesday, October 28 =E2=80=93 Friday, October 30



Thank you for your interest in KVM. We're looking forward to your
submissions and, if the conditions will permit it, to seeing you at the
KVM Forum 2020 in October!

-your KVM Forum 2020 Program Committee

Please contact us with any questions or comments at
kvm-forum-2020-pc@redhat.com


