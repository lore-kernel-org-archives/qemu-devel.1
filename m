Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BA3C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9D62080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9D62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn0b9-0000oK-HY
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42758)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hn0ax-0000Nu-PL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hn0aq-0008EP-Ow
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:00:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hn0ao-0008D4-0w; Mon, 15 Jul 2019 09:00:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2186C30821BE;
 Mon, 15 Jul 2019 13:00:33 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50D9A6090E;
 Mon, 15 Jul 2019 13:00:31 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190712104617.94707-1-sgarzare@redhat.com>
 <5017daf6-2739-d260-09fd-cfccd6c77bc1@redhat.com>
 <20190715081601.rpvavykcuhyr3fiw@steredhat>
 <3f090545-0ca1-ca42-7e44-49f82e3ff760@redhat.com>
 <20190715125005.zzcslkysazi6rqdb@steredhat>
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
Message-ID: <47523a4f-04a5-7ef9-9023-00c281644995@redhat.com>
Date: Mon, 15 Jul 2019 15:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715125005.zzcslkysazi6rqdb@steredhat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MZqzZgcxibJETVaipoBn0UymEIgde6Fn8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 15 Jul 2019 13:00:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] gluster: fix .bdrv_reopen_prepare when
 backing file is a JSON object
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MZqzZgcxibJETVaipoBn0UymEIgde6Fn8
Content-Type: multipart/mixed; boundary="lupbjG0waUj2m5TP5FlD0S0vmSyjOA23b";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, integration@gluster.org
Message-ID: <47523a4f-04a5-7ef9-9023-00c281644995@redhat.com>
Subject: Re: [PATCH] gluster: fix .bdrv_reopen_prepare when backing file is a
 JSON object
References: <20190712104617.94707-1-sgarzare@redhat.com>
 <5017daf6-2739-d260-09fd-cfccd6c77bc1@redhat.com>
 <20190715081601.rpvavykcuhyr3fiw@steredhat>
 <3f090545-0ca1-ca42-7e44-49f82e3ff760@redhat.com>
 <20190715125005.zzcslkysazi6rqdb@steredhat>
In-Reply-To: <20190715125005.zzcslkysazi6rqdb@steredhat>

--lupbjG0waUj2m5TP5FlD0S0vmSyjOA23b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.07.19 14:50, Stefano Garzarella wrote:
> On Mon, Jul 15, 2019 at 12:53:57PM +0200, Max Reitz wrote:
>> On 15.07.19 10:16, Stefano Garzarella wrote:
>>> On Fri, Jul 12, 2019 at 08:35:12PM +0200, Max Reitz wrote:
>>>> On 12.07.19 12:46, Stefano Garzarella wrote:
>>>>> When the backing_file is specified as a JSON object, the
>>>>> qemu_gluster_reopen_prepare() fails with this message:
>>>>>     invalid URI json:{"server.0.host": ...}
>>>>>
>>>>> In this case, we should call qemu_gluster_init() using the QDict
>>>>> 'state->options' that contains the parameters already parsed.
>>>>>
>>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1542445
>>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> ---
>>>>>  block/gluster.c | 11 ++++++++++-
>>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/gluster.c b/block/gluster.c
>>>>> index 62f8ff2147..26971db1ea 100644
>>>>> --- a/block/gluster.c
>>>>> +++ b/block/gluster.c
>>>>> @@ -931,7 +931,16 @@ static int qemu_gluster_reopen_prepare(BDRVReo=
penState *state,
>>>>>      gconf->has_debug =3D true;
>>>>>      gconf->logfile =3D g_strdup(s->logfile);
>>>>>      gconf->has_logfile =3D true;
>>>>> -    reop_s->glfs =3D qemu_gluster_init(gconf, state->bs->filename,=
 NULL, errp);
>>>>> +    /*
>>>>> +     * If 'bs->filename' starts with "json:", then 'state->options=
' will
>>>>> +     * contain the parameters already parsed.
>>>>> +     */
>>>>> +    if (state->bs->filename && !strstart(state->bs->filename, "jso=
n:", NULL)) {
>>>>> +        reop_s->glfs =3D qemu_gluster_init(gconf, state->bs->filen=
ame, NULL,
>>>>> +                                         errp);
>>>>> +    } else {
>>>>> +        reop_s->glfs =3D qemu_gluster_init(gconf, NULL, state->opt=
ions, errp);
>>>>> +    }
>>>>
>>>> Hmmm, aren=E2=80=99t they always in state->options?
>>>
>>> Yes, you are rigth, but the qemu_gluster_parse() doesn't search for t=
he
>>> 'filename' in the QDict *options.
>>>
>>> Maybe I can simply modify it in this way in order to hanlde this case=
,
>>> calling qemu_gluster_init() only with 'state->options'.
>>>
>>> diff --git a/block/gluster.c b/block/gluster.c
>>> index 26971db1ea..91d674cd2b 100644
>>> --- a/block/gluster.c
>>> +++ b/block/gluster.c
>>> @@ -695,6 +695,11 @@ static int qemu_gluster_parse(BlockdevOptionsGlu=
ster *gconf,
>>>                                QDict *options, Error **errp)
>>>  {
>>>      int ret;
>>> +
>>> +    if (!filename) {
>>> +        filename =3D qdict_get_try_str(options, GLUSTER_OPT_FILENAME=
);
>>> +    }
>>> +
>>>      if (filename) {
>>>          ret =3D qemu_gluster_parse_uri(gconf, filename);
>>>          if (ret < 0) {
>>>
>>>
>>> Do you think it is better/cleaner?
>>
>> No, because the rest of the function completely ignores @options if
>> @filename is set.
>>
>> Hm.  I can=E2=80=99t think of anything better than your original solut=
ion, then.
>>  Except the =E2=80=9Cstate->bs->filename=E2=80=9D should probably be a=

>> =E2=80=9Cstate->bs->filename[0]=E2=80=9D (as Patchew has pointed out).=

>=20
> Sure, I'll fix it in the v2.

Oh, wait.  You can actually just use state->bs->exact_filename.  That
will never be a json:{} filename, so you don=E2=80=99t have to do the pre=
fix
check (just see whether it is empty).

Max


--lupbjG0waUj2m5TP5FlD0S0vmSyjOA23b--

--MZqzZgcxibJETVaipoBn0UymEIgde6Fn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0seO0ACgkQ9AfbAGHV
z0DXtQgAt9HjStj6BNiGBdnqJ/DmKP+sWn+8qALaS6ZUIdn3gUtVOzUjyUTHbqOv
ud4c2A8z4kTSKUylBdw3603lLE4GwCCAig1qXnAg14Jk15Hq88CDr3aZclxI2xKt
gWHvAlmyhOkvx0mifkBHEHsBWTQU/DIR2cyztyjo3xpSzXAsUPtYrHFoMLU7CfFi
H5padicUcEOqTDlBN5NDtbz0x31cskrcM8IBJTGozAcOXMohuaVYsKx8Wt++r2Nh
+qqDEfmcwEmv1LX3vV8VWLuCiAgJ96KOf+Q45GbBXpD3GFzr3s3lVstnU9J3rGes
gkqhambmHUh9of9qHBOhLAdNoAgtWw==
=xJRk
-----END PGP SIGNATURE-----

--MZqzZgcxibJETVaipoBn0UymEIgde6Fn8--

