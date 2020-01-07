Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FBC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009BD2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnDHb9fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009BD2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq7l-0002hY-1T
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iooyH-0004ZE-GJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iooyF-0005kU-IO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:32:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iooyF-0005jq-Cr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578403950;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQ8YZ4kxjS/Wvi2iTyW3cG1BWPlzmL6gE4ayGKp9Syw=;
 b=LnDHb9frWaT1RU/FS/vbV0Sc31dm+qknQF/VPTJwNZXgGgE1qxFjkg8G6HTihHPbSrCybM
 LH98AZwH1lKvlQn2+mnRbl3GV1E6jI6cuLRHDdRDhKGnPXRqLqO6R19iUHVjbaZtXMnitd
 YJEU8wlJ8TVykfffbkq2P+wGq0scguQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-GYwiqeN3PdyEDhCVhyAzgA-1; Tue, 07 Jan 2020 08:32:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1E31DBA3
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 13:32:28 +0000 (UTC)
Received: from redhat.com (ovpn-116-141.ams2.redhat.com [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DABD5D9CA;
 Tue,  7 Jan 2020 13:32:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 01/10] migration: Increase default number of multifd
 channels to 16
In-Reply-To: <20200107124934.GK3368802@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Tue, 7 Jan 2020 12:49:34 +0000")
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-2-quintela@redhat.com>
 <20200103165832.GU2753983@redhat.com> <87mub4xurf.fsf@trasno.org>
 <20200107124934.GK3368802@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 07 Jan 2020 14:32:24 +0100
Message-ID: <87muazpf2v.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: GYwiqeN3PdyEDhCVhyAzgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Fri, Jan 03, 2020 at 07:25:08PM +0100, Juan Quintela wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>> > On Wed, Dec 18, 2019 at 03:01:10AM +0100, Juan Quintela wrote:
>> >> We can scale much better with 16, so we can scale to higher numbers.
>> >
>> > What was the test scenario showing such scaling ?
>>=20
>> On my test hardware, with 2 channels we can saturate around 8Gigabit max=
,
>> more than that, and the migration thread is not fast enough to fill the
>> network bandwidth.
>>=20
>> With 8 that is enough to fill whatever we can find.
>> We used to have a bug where we were getting trouble with more channels
>> than cores.  That was the initial reason why the default was so low.
>>=20
>> So, pros/cons are:
>> - have low value (2).  We are backwards compatible, but we are not using
>>   all  bandwith.  Notice that we will dectect the error before 5.0 is
>>   out and print a good error message.
>>=20
>> - have high value (I tested 8 and 16).  Found no performance loss when
>>   moving to lower bandwidth limits, and clearly we were able to saturate
>>   the higher speeds (I tested on localhost, so I had big enough bandwidt=
h)
>>=20
>>=20
>> > In the real world I'm sceptical that virt hosts will have
>> > 16 otherwise idle CPU cores available that are permissible
>> > to use for migration, or indeed whether they'll have network
>> > bandwidth available to allow 16 cores to saturate the link.
>>=20
>> The problem here is that if you have such a host, and you want to have
>> high speed migration, you need to configure it.  My measumermets are
>> that high number of channels don't affect performance with low
>> bandwidth, but low number of channels affect performance with high
>> bandwidth speed.
>
> I'm not concerned about impact on performance of migration on a
> low bandwidth link, rather I'm concerned about impact on performance
> of other guests on the host. It will cause migration to contend with
> other guest's vCPUs and network traffic.=20

Two things here:
- vcpus:  If you want migration to consume all the bandwidth, you are
  happy with it using more vcpus.
- bandwidth: It will only consume only the one that the guest has
  assigned, split (we hope evenly) between all the channels.

My main reason to have a higher number of channels is:
- test better the code with more than one channel
- work "magically" well in all scenarios.  With a low number of
  channels, we are not going to be able to saturate a big network pipe.


>
>> So, if we want to have something that works "automatically" everywhere,
>> we need to put it to at least 8.  Or we can trust that management app
>> will do the right thing.
>
> Aren't we still setting the bandwidth limit to MB bandwidth out of the
> box, so we already require mgmt app to change settings to use more
> bandwidth ?=20

Yeap.  This is the default bandwidth.

#define MAX_THROTTLE  (32 << 20)


>> If you are using a low value of bandwidth, the only difference with 16
>> channels is that you are using a bit more memory (just the space for the
>> stacks) and that you are having less contention for the locks (but with
>> low bandwidth you are not having contention anyways).
>>=20
>> So,  I think that the question is:

Note that my idea is to make multifd "default" in the near future (5.1
timeframe or so).

>> - What does libvirt prefferes
>
> Libvirt doesn't really have an opinion in this case. I believe we'll
> always set the number of channels on both src & dst, so we don't
> see the defaults.

What does libvirt does today for this value?

>> - What does ovirt/openstack preffer
>
> Libvirt should insulate them from any change in defaults in QEMU
> in this case, but always explicitly setting channels on src & dst
> to match.

I agree here, they should don't care by default.

>> - Do we really want that the user "have" to configure that value
>
> Right so this is the key quesiton - for a user not using libvirt
> or a libvirt based mgmt app, what we do want out out of the box
> migration to be tuned for ?

In my opinion, we should have something like:
- multifd: enabled by default
- max downtime: 300 ms (current) looks right to me
- max bandwidth: 32MB/s (current) seems a bit low. 100MB/s (i.e. almost
  full gigabit ethernet) seems reasonable to me.  Having a default for
  10Gigabit ethernet or similar seems too high.

> If we want to maximise migration performance, at cost of anything
> else, then we can change the migration channels count, but probably
> also ought to remove the 32MB bandwidth cap as no useful guest with
> active apps will succeed migration with a 32MB cap.

Will start another series with the current values to discuss all the
defaults, ok?

thanks for the comments, Juan.


