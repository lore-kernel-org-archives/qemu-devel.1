Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBD9C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2B62133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2B62133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbsVp-0006vH-K2
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 16:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51498)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbsQU-00056b-Ci
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbsQS-0000mo-Qi
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:03:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbsQL-0000ih-N2; Fri, 14 Jun 2019 16:03:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75FA430C31B7;
 Fri, 14 Jun 2019 20:03:32 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B72E60CA3;
 Fri, 14 Jun 2019 20:03:22 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
Date: Fri, 14 Jun 2019 22:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NJnI0tz73SXoo21MeXRsVkUcFTnz8uPnG"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 14 Jun 2019 20:03:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 4/7] block: introduce backup-top filter
 driver
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NJnI0tz73SXoo21MeXRsVkUcFTnz8uPnG
Content-Type: multipart/mixed; boundary="Lh2qxbmlBoQebpGEbUl5MSQ2yZ6TTERbD";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>
Message-ID: <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
Subject: Re: [PATCH v8 4/7] block: introduce backup-top filter driver
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
In-Reply-To: <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>

--Lh2qxbmlBoQebpGEbUl5MSQ2yZ6TTERbD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 18:22, Vladimir Sementsov-Ogievskiy wrote:
> 14.06.2019 15:57, Max Reitz wrote:
>> On 14.06.19 11:04, Vladimir Sementsov-Ogievskiy wrote:
>>> 13.06.2019 18:57, Max Reitz wrote:
>>>> On 29.05.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Backup-top filter does copy-before-write operation. It should be
>>>>> inserted above active disk and has a target node for CBW, like the
>>>>> following:
>>>>>
>>>>>       +-------+
>>>>>       | Guest |
>>>>>       +-------+
>>>>>           |r,w
>>>>>           v
>>>>>       +------------+  target   +---------------+
>>>>>       | backup_top |---------->| target(qcow2) |
>>>>>       +------------+   CBW     +---------------+
>>>>>           |
>>>>> backing |r,w
>>>>>           v
>>>>>       +-------------+
>>>>>       | Active disk |
>>>>>       +-------------+
>>>>>
>>>>> The driver will be used in backup instead of write-notifiers.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
>>>>> ---
>>>>>    block/backup-top.h  |  64 +++++++++
>>>>>    block/backup-top.c  | 322 ++++++++++++++++++++++++++++++++++++++=
++++++
>>>>>    block/Makefile.objs |   2 +
>>>>>    3 files changed, 388 insertions(+)
>>>>>    create mode 100644 block/backup-top.h
>>>>>    create mode 100644 block/backup-top.c
>>>>>
>>>>> diff --git a/block/backup-top.h b/block/backup-top.h
>>>>> new file mode 100644
>>>>> index 0000000000..788e18c358
>>>>> --- /dev/null
>>>>> +++ b/block/backup-top.h
>>
>> [...]
>>
>>>>> +/*
>>>>> + * bdrv_backup_top_append
>>>>> + *
>>>>> + * Append backup_top filter node above @source node. @target node =
will receive
>>>>> + * the data backed up during CBE operations. New filter together w=
ith @target
>>>>> + * node are attached to @source aio context.
>>>>> + *
>>>>> + * The resulting filter node is implicit.
>>>>
>>>> Why?  It=E2=80=99s just as easy for the caller to just make it impli=
cit if it
>>>> should be.  (And usually the caller should decide that.)
>>>
>>> Personally, I don't know what are the reasons for filters to bi impli=
cit or not,
>>> I just made it like other job-filters.. I can move making-implicit to=
 the caller
>>> or drop it at all (if it will work).
>>
>> Nodes are implicit if they haven=E2=80=99t been added consciously by t=
he user.
>> A node added by a block job can be non-implicit, too, as mirror shows;=

>> If the user specifies the filter-node-name option, they will know abou=
t
>> the node, thus it is no longer implicit.
>>
>> If the user doesn=E2=80=99t know about the node (they didn=E2=80=99t g=
ive the
>> filter-node-name option), the node is implicit.
>>
>=20
> Ok, I understand it. But it doesn't show, why it should be implicit?
> Isn't it less buggy to make all filters explicit? We don't hide implici=
t nodes
> from query-named-block-nodes (the only interface to explore the whole g=
raph for now)
> anyway. And we can't absolutely hide side effects of additional node in=
 the graph.

Well, we try, at least.  At least we hide them from query-block.

> So, is there any real benefit of supporting separation into implicit an=
d explicit filters?
> It seems for me that it only complicates things...
> In other words, what will break if we make all filters explicit?

The theory is that qemu may decide to add nodes at any point, but at
least when managing chains etc., they may not be visible to the user.  I
don=E2=80=99t think we can get rid of them so easily.

One example that isn=E2=80=99t implemented yet is copy-on-read.  In theor=
y,
specifying copy-on-read=3Don for -drive should create an implicit COR nod=
e
on top.  The user shouldn=E2=80=99t see that node when inspecting the dri=
ve or
when issuing block jobs on it, etc.  And this node has to stay there
when the user does e.g. an active commit somewhere down the chain.

That sounds like a horrible ordeal to implement, so it hasn=E2=80=99t bee=
n done
yet.  Maybe it never will.  It isn=E2=80=99t that bad for the job filters=
,
because they generally freeze the block graph, so there is no problem
with potential modifications.

All in all I do think having implicit nodes makes sense.  Maybe not so
much now, but in the future (if someone implements converting -drive COR
and throttle options to implicit nodes...).

>> [...]
>>
>>>>> +static int coroutine_fn backup_top_co_flush(BlockDriverState *bs)
>>>>> +{
>>>>> +    if (!bs->backing) {
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    return bdrv_co_flush(bs->backing->bs);
>>>>
>>>> Should we flush the target, too?
>>>
>>> Hm, you've asked it already, on previous version :)
>>
>> I wasn=E2=80=99t sure...
>>
>>> Backup don't do it,
>>> so I just keep old behavior. And what is the reason to flush backup t=
arget
>>> on any guest flush?
>>
>> Hm, well, what=E2=80=99s the reason not to do it?
>=20
> guest flushes will be slowed down?

Hm, the user could specify cache=3Dunsafe if they don=E2=80=99t care.  Wh=
ich gives
me second thoughs... [1]

>> Also, there are not only guest flushes.  bdrv_flush_all() exists, whic=
h
>> is called when the guest is stopped.  So who is going to flush the
>> target if not its parent?
>>
>> [...]
>=20
> Backup job? But filter should not relay on it..

Hm.  Backup job actually doesn=E2=80=99t sound that wrong.

> But should really filter do that job, or it is here only to do CBW? May=
be target
> must have another parent which will care about flushing.
>=20
> Ok, I think I'll flush target here too for safety, and leave a comment,=
 that something
> smarter would be better.
> (or, if we decide to flush all children by default in generic code, I'l=
l drop this handler)

[1] Thinking more about this, for normal backups the target file does
not reflect a valid disk state until the backup is done; just like for
qemu-img convert.  Just like qemu-img convert, there is therefore no
reason to flush the target until the job is done.

But there is also the other case of image fleecing.  In this case, the
target will have another parent, so bdrv_flush_all() will be done by
someone.  Still, it intuitively makes sense to me that in this case, the
backup-top filter should flush the target if the guest decides to flush
the device (so that the target stays consistent on disk).

backup-top currently cannot differentiate between the cases, but maybe
that is generally a useful hint to give to it?  (That is, whether the
target has a consistent state or not.)

[...]

>>>>> +        }
>>>>> +    } else {
>>>>> +        /* Source child */
>>>>> +        if (perm & BLK_PERM_WRITE) {
>>>>
>>>> Or WRITE_UNCHANGED, no?
>>>
>>> Why? We don't need doing CBW for unchanged write.
>>
>> But we will do it still, won=E2=80=99t we?
>>
>> (If an unchanging write comes in, this driver will handle it just like=
 a
>> normal write, will it not?)
>=20
> No, it will not, I check this flag in backup_top_co_pwritev

Oops.  My bad.

Max


--Lh2qxbmlBoQebpGEbUl5MSQ2yZ6TTERbD--

--NJnI0tz73SXoo21MeXRsVkUcFTnz8uPnG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0D/YgACgkQ9AfbAGHV
z0DbiQgApyZqpH5QZWfyoMMhP/Pw6JI/VkJzPFNaxeOxEMrDcsNsikBW3LOVLV/l
Vytvv51y3SabOh0PswquD49YDWkgiqkSZIw5v9JPAiQs+bx4Iz8oFsXJvLGJ9oGw
PT1z+Usbo/yvr5CP3sjbSvd2hxvYWk6fhDOyNMdWS1Dm8i0HqxV3XAfHENGw0aaE
VzRm7EkTMkzdDp7ir3w60/CWRU4wydGobefXDxjZ8MqNd+Nf/P/1TmeC00XcRREF
g8sOqRGVoU9/zHeoo7rYF/OgMPo/hEG3T6OAvh9URXHyPBWBhLiwUAb4OerPEHcc
kQ2exh8+3UOKujWCoiF7tiuvkRs0IA==
=ZuWu
-----END PGP SIGNATURE-----

--NJnI0tz73SXoo21MeXRsVkUcFTnz8uPnG--

