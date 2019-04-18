Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C0FC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 17:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5390217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 17:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5390217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44901 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBE3-0007aD-TH
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 13:53:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHBD0-00077L-Qv
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHB8w-0002a5-8o
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHB8w-0002ZB-0p
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:48:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7890F3002E05;
	Thu, 18 Apr 2019 17:48:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 078881001E8A;
	Thu, 18 Apr 2019 17:48:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 876A91138648; Thu, 18 Apr 2019 19:48:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
	<20190418112610.GO13773@redhat.com>
Date: Thu, 18 Apr 2019 19:48:09 +0200
In-Reply-To: <20190418112610.GO13773@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Thu, 18 Apr 2019 12:26:10 +0100")
Message-ID: <877ebrmch2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 18 Apr 2019 17:48:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] How do we do user input bitmap properties?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>,
	dgilbert@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
	Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418174809.tGICK8IgrB9b11Jbg55OqRGUNun28ydcgz9CMjjsAsw@z>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Apr 18, 2019 at 11:28:41AM +0200, Andrew Jones wrote:
>> Hi all,
>>=20
>> First some background:
>>=20
>> For the userspace side of AArch64 guest SVE support we need to
>> expose KVM's allowed vector lengths bitmap to the user and allow
>> the user to choose a subset of that bitmap. Since bitmaps are a
>> bit awkward to work with then we'll likely want to expose it as
>> an array of vector lengths instead. Also, assuming we want to
>> expose the lengths as number-of-quadwords (quadword =3D=3D 128 bits
>> for AArch64 and vector lengths must be multiples of quadwords)
>> rather than number-of-bits, then an example array (which will
>> always be a sequence) might be
>>=20
>>  [ 8, 16, 32 ]
>>=20
>> The user may choose a subsequence, but only through truncation,
>> i.e. [ 8, 32 ] is not valid, but [ 8, 16 ] is.
>>=20
>> Furthermore, different hosts may support different sequences
>> which have the same maximum. For example, if the above sequence
>> is for Host_A, then Host_B could be
>>=20
>>  [ 8, 16, 24, 32 ]
>>=20
>> The host must support all lengths in the sequence, which means
>> that while Host_A supports 32, since it doesn't support 24 and
>> we can only truncate sequences, we must use either [ 8 ] or
>> [ 8, 16 ] for a compatible sequence if we intend to migrate
>> between the hosts.
>>=20
>> Now to the $SUBJECT question:
>>=20
>> My feeling is that we should require the sequence to be
>> provided on the command line as a cpu property. Something
>> like
>>=20
>>   -cpu host,sve-vl-list=3D8:16
>>=20
>> (I chose ':' for the delimiter because ',' can't work, but
>> if there's a better choice, then that's fine by me.)
>>=20
>> Afaict a property list like this will require a new parser,

We had 20+ of those when I last counted.  Among the more annoying
reasons CLI QAPIfication is hard[1].

>> which feels a bit funny since it seems we should already
>> have support for this type of thing somewhere in QEMU. So,
>> the question is: do we? I see we have array properties, but
>> I don't believe that works with the command line. Should we
>> only use QMP for this? We already want some QMP in order to
>> query the supported vector lengths. Maybe we should use QMP
>> to set the selection too? But then what about command line
>> support for developers? And if the property is on the command
>> line then we don't have to add it to the migration stream.
>
> You should be able to use arrays from the CLI with QemuOpts by repeating
> the same option name many times, though I can't say it is a very
> nice approach if you have many values to list as it gets very repetative.

Yes, this is one of the ways the current CLI does lists.  It's also one
of the more annoying reasons CLI QAPIfication is hard[2].

QemuOpts let the last param=3Dvalue win the stupidest way that could
possibly work (I respect that): add to the front of the list, search it
front to back.

Then somebody discovered that if you search the list manually, you can
see them all, and abuse that to get a list-valued param.  I'm sure that
felt clever at the time.

Another way to do lists the funky list feature of string input and opts
visitor.  Yet another annoying reason CLI QAPIfication is hard[3].

We use the opts visitor's list feature for -numa node,cpus=3D...  Hmm,
looks like we even combine it with the "multiple param=3Dvalue build up a
list" technique: -smp node,cpus=3D0-1,cpus=3D4-5 denotes [0,1,4,5].

> That's the curse of not having a good CLI syntax for non-scalar data in
> QemuOpts & why Markus believes we should switch to JSON for the CLI too
>
>      -cpu host,sve-vl=3D8,sve-vl=3D16

We actually have CLI syntax for non-scalar data: dotted keys.  Dotted
keys are syntactic sugar for JSON.  It looks friendlier than JSON for
simple cases, then gets uglier as things get more complex, and then it
falls apart: it can't quite express all of JSON.

Example: sve-vl.0=3D8,sve-vl.1=3D16
    gets desugared into {"sve": [8, 16]}
    if the QAPI schema has 'sve': ['int'].

The comment at the beginning of util/keyval.c explains it in more
detail.

It powers -blockdev and -display.  Both options accept either JSON or
dotted keys.  If the option argument starts with '{', it's JSON.
Management applications should stick to JSON.


[1] Towards a more expressive and introspectable QEMU command line
https://www.linux-kvm.org/images/f/f2/Armbru-qapi-cmdline_1.pdf
Slide 34 "Backward compatibility" item 1

[2] ibid, item 4

[3] ibid, item 3

