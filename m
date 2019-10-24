Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9F6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC09620650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNC271jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC09620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeaU-0006BW-7o
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNdbp-0001JN-77
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNdbn-0003jW-2v
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:57:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40812
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNdbm-0003j5-UO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571925418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLh4sH6giV5qwkksrveGe51we5sb34+CNwTVgdLK1yo=;
 b=PNC271jp8z9T0HwVvn2wj8BqYfw7rmDPKIjb3sTVPgsHBS7d5ugGZIMZUlCytOrX7YHjUw
 HMCLsJ6my4A6v0oysS2iEu5GQq9WB1IkUtDe/ZSTROW/60mM3uMy8c8MUDy1+tY/RPOFVG
 vlLE+Z1qJwku7Qf2vvWGPMZSI1uGipQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-gzni6ymLMwuBaL9szP4sCw-1; Thu, 24 Oct 2019 09:56:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D8021005500;
 Thu, 24 Oct 2019 13:56:52 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AC86600CC;
 Thu, 24 Oct 2019 13:56:47 +0000 (UTC)
Date: Thu, 24 Oct 2019 14:56:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH] iothread: add set_iothread_poll_* commands
Message-ID: <20191024135645.GG2877@work-vm>
References: <5DAEB9D3.3080503@huawei.com>
 <20191023151903.GI9574@stefanha-x1.localdomain>
 <5DB1ACF2.9080500@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5DB1ACF2.9080500@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: gzni6ymLMwuBaL9szP4sCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 jiangyiwen <jiangyiwen@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhenyu Ye (yezhenyu2@huawei.com) wrote:
>=20
>=20
> On 2019/10/23 23:19, Stefan Hajnoczi wrote:
> > On Tue, Oct 22, 2019 at 04:12:03PM +0800, yezhenyu (A) wrote:
> >> Since qemu2.9, QEMU added three AioContext poll parameters to struct
> >> IOThread: poll_max_ns, poll_grow and poll_shrink. These properties are
> >> used to control iothread polling time.
> >>
> >> However, there isn't properly hmp commands to adjust them when the VM =
is
> >> alive. It's useful to adjust them online when observing the impact of
> >> different property value on performance.
> >>
> >> This patch add three hmp commands to adjust iothread poll-* properties
> >> for special iothread:
> >>
> >> set_iothread_poll_max_ns: set the maximum polling time in ns;
> >> set_iothread_poll_grow: set how many ns will be added to polling time;
> >> set_iothread_poll_shrink: set how many ns will be removed from polling
> >> time.
> >>
> >> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> >> ---
> >> hmp-commands.hx | 42 ++++++++++++++++++++
> >> hmp.c | 30 +++++++++++++++
> >> hmp.h | 3 ++
> >> include/sysemu/iothread.h | 6 +++
> >> iothread.c | 80 +++++++++++++++++++++++++++++++++++++++
> >> qapi/misc.json | 23 +++++++++++
> >> 6 files changed, 184 insertions(+)
> >=20
> > poll-max-ns, poll-grow, poll-shrink are properties of IOThread objects.
> > They can already be modified at runtime using:
> >=20
> >   $ qemu -object iothread,id=3Diothread1
> >   (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> >=20
> > I think there is no need for a patch.
> >=20
> > Stefan
> >=20
>=20
> Thanks for your review. I have considered using the `qom-set` command to =
modify
> IOThread object's properties, however, this command is not friendly to pr=
imary
> users. The help info for this command is only:
>=20
>     qom-set path property value -- set QOM property
>=20
> It's almost impossible to get the correct `path` parameter for primary us=
er.

Is this just a matter of documenting how to do it?

It sounds like there's no need for a new QMP command though;  if you
want an easier HMP command I'd probably still take it (because HMP is ok
at having things for convenience) - but not if it turns out that just
adding a paragraph of documentation is enough.

Dave

> This patch provides a more convenient and easy-use hmp&qmp interface to m=
odify
> these IOThread properties. I think this patch still has a little value.
>=20
> And I can implement this patch compactly by reusing your code.
>=20
> Waiting for your reply.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


