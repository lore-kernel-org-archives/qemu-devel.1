Received: from eggs.gnu.org ([2001:4830:134:3::10]:53608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eCRh7-00071p-6O
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eCRh1-0006md-50
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:51:09 -0500
Date: Wed, 8 Nov 2017 14:50:38 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171108145038.7ms6llpt4vjnh33q@starbug-vm.ie.oracle.com>
References: <cover.1510093478.git.jcody@redhat.com>
	<41ed8543e005205118438328c7e162532729d9c7.1510093478.git.jcody@redhat.com>
	<20171108104737.xtxfex7leabfbqyc@starbug-vm.ie.oracle.com>
	<a888b534-f285-6d02-fdb6-9faae79879fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <a888b534-f285-6d02-fdb6-9faae79879fb@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 7/7] block/curl: code
 cleanup to comply with coding style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, rjones@redhat.com, namei.unix@gmail.com

On Wed, Nov 08, 2017 at 08:26:57AM -0600, Eric Blake wrote:
>On 11/08/2017 04:47 AM, Darren Kenny wrote:
>> Hi Jeff,
>>
>> While I'm relatively new to this community, I do have some comments
>> about the styling in this file.
>>
>> I don't see anything in the CODING_STYLE file that tells me I'm
>> wrong here, but it's certainly possible...
>>
>> More inline.
>>
>
>>> -// #define DEBUG_CURL
>>> -// #define DEBUG_VERBOSE
>
>This is definitely against style (checkpatch.pl flags it),
>
>>> +/*
>>> + #define DEBUG_CURL
>>> + #define DEBUG_VERBOSE
>>> +*/
>>
>
>while you are correct that this is not quite usual style.
>
>> Is it not more common to use the style:
>>
>> =C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0 * text
>> =C2=A0=C2=A0=C2=A0 */
>
>But, since checkpatch.pl doesn't flag it, and since it is easier to
>remove the leading and trailing /* and */ to enable the debug #defines
>(compared to editing every single line of the comment), I don't see a
>problem with the style chosen here.
>

If that is the purpose, maybe an #if 0 is more appropriate or #ifdef
DEBUG, or similar.

Isn't the purpose of styling to be consistent? As such should we not
be trying to use the multi-line style set out at the top of the file?

>
>>> @@ -235,7 +236,7 @@ static size_t curl_header_cb(void *ptr, size_t
>>> size, size_t nmemb, void *opaque)
>>> /* Called from curl_multi_do_locked, with s->mutex held.=C2=A0 */
>>> static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void
>>> *opaque)
>>> {
>>> -=C2=A0=C2=A0=C2=A0 CURLState *s =3D ((CURLState*)opaque);
>>> +=C2=A0=C2=A0=C2=A0 CURLState *s =3D opaque;
>>
>> Not sure about this one - while it may not be strictly necessary to
>> do the casting, from a readability point of view it is helpful to
>> see the cast - possibly with the outer brackets removed:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 CURLState *s =3D (CURLState*)opaque;
>
>I _am_ sure about it. The cast from void* is pointless (this is C, not
>C++), and this is one of the changes that Jeff specifically made in v3
>that was not present in v2, because I requested that we lose the cast
>(in general, we try to avoid as many casts as possible).

Fair enough.

>
>>> @@ -876,13 +880,13 @@ static void curl_setup_preadv(BlockDriverState
>>> *bs, CURLAIOCB *acb)
>>>
>>> =C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&s->mutex);
>>>
>>> -=C2=A0=C2=A0=C2=A0 // In case we have the requested data already (e.=
g. read-ahead),
>>> -=C2=A0=C2=A0=C2=A0 // we can just call the callback and be done.
>>> +=C2=A0=C2=A0=C2=A0 /* In case we have the requested data already (e.=
g. read-ahead),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 we can just call the callback a=
nd be done. */
>>
>> Please don't do a multi-line comment like this, it is much more
>> obvious that the second line is a comment if you use the more normal
>> format of as outlined earlier by me.
>
>Indeed, while I don't mind the style used on the #define DEBUG_*, this
>one could be touched up to be more idiomatic.
>

Thanks,

Darren.
