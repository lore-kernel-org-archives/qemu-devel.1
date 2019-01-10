Received: from eggs.gnu.org ([209.51.188.92]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghWOA-0005I3-So
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghWOA-0005aQ-3N
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:12:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghWO9-0005Zx-TH
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:12:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<c374ab1ece7bfc933669d8807a54bf362d715a23.1545598229.git.DirtY.iCE.hu@gmail.com>
	<65a00798-9a26-b0bb-b70a-cfd292169123@redhat.com>
Date: Thu, 10 Jan 2019 10:12:27 +0100
In-Reply-To: <65a00798-9a26-b0bb-b70a-cfd292169123@redhat.com> (Eric Blake's
	message of "Wed, 9 Jan 2019 19:43:51 -0600")
Message-ID: <8736q098qs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 43/52] audio: add mixeng option
 (documentation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: dirty.ice.hu@gmail.com, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 12/23/18 2:52 PM, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wrote:
>> This will allow us to disable mixeng when we use a decent backend.
>>=20
>> Disabling mixeng have a few advantages:
>> * we no longer convert the audio output from one format to another, when
>>   the underlying audio system would just convert it to a third format.
>>   We no longer convert, only the underlying system, when needed.
>> * the underlying system probably has better resampling and sample format
>>   converting methods anyway...
>> * we may support formats that the mixeng currently does not support (S24
>>   or float samples, more than two channels)
>> * when using an audio server (like pulseaudio) different sound card
>>   outputs will show up as separate streams, even if we use only one
>>   backend
>>=20
>> Disadvantages:
>> * audio capturing no longer works (wavcapture, and vnc audio extension)
>> * some backends only support a single playback stream or very picky
>>   about the audio format.  In this case we can't disable mixeng.
>>=20
>> However mixeng is not removed, only made optional, so this shouldn't be
>> a big concern.
>>=20
>> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.co=
m>
>> ---
>>  qapi/audio.json | 5 +++++
>>  qemu-options.hx | 6 ++++++
>>  2 files changed, 11 insertions(+)
>>=20
>> diff --git a/qapi/audio.json b/qapi/audio.json
>> index 56d8ce439f..180bf207a8 100644
>> --- a/qapi/audio.json
>> +++ b/qapi/audio.json
>> @@ -184,6 +184,10 @@
>>  #
>>  # General audio backend options that are used for both playback and rec=
ording.
>>  #
>> +# @mixeng: #optional use QEMU's mixing engine to mix all streams inside=
 QEMU.
>
> The #optional tag is no longer necessary (the docs generator figures it
> out from the '*mixeng' name below).

In fact, the qapi generator had special code to detect and reject
#optional tags for some six months (from commit 1d8bda128d2 to
67ab1ce9263), just to ensure patches in flight don't add them.  This one
has been in flight for even longer.

[...]
