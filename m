Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47094C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0581F20883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0581F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDjtm-0007P0-W8
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 02:06:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjsq-0006tG-Na
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjsp-0000XK-CO
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDjsk-0000Pm-Jk; Tue, 09 Apr 2019 02:05:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3D813099FC5;
	Tue,  9 Apr 2019 06:05:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5089761090;
	Tue,  9 Apr 2019 06:05:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id CCC051138648; Tue,  9 Apr 2019 08:05:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
	<20190408172202.GH3926@redhat.com>
	<d40c9fd6-6ae2-95f3-2f63-151ee1f13d0f@redhat.com>
Date: Tue, 09 Apr 2019 08:05:15 +0200
In-Reply-To: <d40c9fd6-6ae2-95f3-2f63-151ee1f13d0f@redhat.com> (Max Reitz's
	message of "Mon, 8 Apr 2019 20:33:22 +0200")
Message-ID: <877ec3iuhw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 09 Apr 2019 06:05:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Whither qemu's ssh driver?
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
Cc: Kevin Wolf <kwolf@redhat.com>, ptoscano@redhat.com,
	"Richard W.M. Jones" <rjones@redhat.com>, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409060515.bSVylwvH0YyWI-uLpRcv51-X4Q9lt9AilCja7Pullv8@z>

Max Reitz <mreitz@redhat.com> writes:

> On 08.04.19 19:22, Richard W.M. Jones wrote:
>> I don't know much about this patch which looks like internal qemu
>> rearrangements so I guess fine.  However I do have a few things to say
>> about the ssh driver ...
>>=20
>> As you know I wrote this a few years ago, and it uses libssh2.
>> libssh2 has not evolved as quickly as we'd like and it may be better
>> to use libssh instead -- despite the names, these are two separate and
>> unrelated libraries.  libssh supports a wider range of SSH encryption
>> and has more features.  It's generally more likely to work against a
>> random SSH server.  It has also been through the FIPS process.  Indeed
>> Red Hat made the decision to switch exclusively to libssh in RHEL 8,
>> if that carries any weight.
>>=20
>> Pino posted a libssh2 -> libssh conversion patch a while back, but it
>> has been somewhat stuck in review.  If I recall the latest concern was
>> whether it performs as well as the libssh2 version.
>>=20
>>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07267.html
>>=20
>> In the meantime I added libssh support to nbdkit.  nbdkit can be used
>> as a complete replacement for qemu's ssh driver.
>>=20
>>   nbdkit ssh host=3Dfoo.example.com disk.img -U tmpdirXXXXXX/sock
>>   qemu -hda nbd:unix:tmpdirXXXXXX/sock
>>=20
>> In fact it's somewhat superior (IMHO) because all of the tricky code
>> handling libssh runs outside qemu in a separate process, improving
>> isolation and potentially allowing separate, restrictive security
>> policies to be applied.  For example it would no longer be necessary
>> to give qemu permission to connect to remote SSH servers.
>>=20
>> Could we make this really smooth somehow?  nbdkit has a concept
>> [https://www.mankier.com/1/nbdkit-captive] where we make it easy to
>> manage external commands owned by nbdkit.  Is there an equivalent
>> feature of qemu where:
>>=20
>>   qemu -object exec,id=3Dnbd1,cmd=3D'nbdkit -f -U $sock ssh ...' \
>>        -drive file.driver=3Dnbd,file.socket=3Dnbd1
>>=20
>> would run the command but also allocate a socket and kill the
>> subcommand on exit (of qemu)?
>>=20
>> Basically I'm trying to think about how to make this a reality:
>>=20
>>   https://rwmj.files.wordpress.com/2018/10/drawing2-svg.png
>>=20
>> Rich.
>
> I don=E2=80=99t disagree with anything you say.  I would prefer to move t=
he less
> well maintained drivers (for which there is no strict performance
> requirement) into a separate process.  nbdkit is perfectly suited for
> that, and the drivers are there, as you say (ssh, curl, vvfat).
>
> Having a nicer interface in qemu would make the transition simple,
> because we could tell users exactly how to change their command line so
> their use case continues to work.  I=E2=80=99m not sure whether it really=
 works,
> though, because I don=E2=80=99t think there is such a simple replacement =
for
> being able to simply pass "ssh://host/path" to qemu and have it work.
>
> But I think it=E2=80=99s still worth it.

I guess that boils down to "patches welcome".

For v1, I wouldn't worry about making the transition simple.  Just show
us some working code.

