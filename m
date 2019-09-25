Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4355C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8871820640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8871820640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD6GU-0003TZ-AE
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iD6EU-00027K-E3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iD6ES-0008KD-Ta
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:17:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iD6ES-0008Jv-Ji
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFDD1316D8C8;
 Wed, 25 Sep 2019 12:17:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E77695D721;
 Wed, 25 Sep 2019 12:17:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7CE4D113864E; Wed, 25 Sep 2019 14:17:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Subject: Re: [PATCH v4 21/24] paaudio: channel-map option
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
 <8f650662fd6cc50baaede260581aeb560eed44fb.1568927990.git.DirtY.iCE.hu@gmail.com>
 <87o8zbma1m.fsf@dusky.pond.sub.org>
 <55ea6ac9-9651-e322-fd84-22b4bedb3a93@gmail.com>
Date: Wed, 25 Sep 2019 14:17:15 +0200
In-Reply-To: <55ea6ac9-9651-e322-fd84-22b4bedb3a93@gmail.com>
 (=?utf-8?B?IlpvbHTDoW4JS8WRdsOhZ8OzIidz?= message of "Tue, 24 Sep 2019
 02:43:32 +0200")
Message-ID: <87impgy3hw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 25 Sep 2019 12:17:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3" <dirty.ice.hu@gmail.com> writes:

> On 2019-09-23 15:12, Markus Armbruster wrote:
>> "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:
>>
>>> Add an option to change the channel map used by pulseaudio.  If not
>>> specified, falls back to an OSS compatible channel map.
>>>
>>> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
>>> ---
>>>   audio/paaudio.c | 18 ++++++++++++++----
>>>   qapi/audio.json |  7 +++++--
>>>   qemu-options.hx |  9 +++++++++
>>>   3 files changed, 28 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/audio/paaudio.c b/audio/paaudio.c
>>> index d195b1caa8..20402b0718 100644
>>> --- a/audio/paaudio.c
>>> +++ b/audio/paaudio.c
>>> @@ -338,17 +338,27 @@ static pa_stream *qpa_simple_new (
>>>           pa_stream_direction_t dir,
>>>           const char *dev,
>>>           const pa_sample_spec *ss,
>>> -        const pa_channel_map *map,
>>> +        const char *map,
>>>           const pa_buffer_attr *attr,
>>>           int *rerror)
>>>   {
>>>       int r;
>>>       pa_stream *stream;
>>>       pa_stream_flags_t flags;
>>> +    pa_channel_map pa_map;
>>>         pa_threaded_mainloop_lock(c->mainloop);
>>>   -    stream =3D pa_stream_new(c->context, name, ss, map);
>>> +    if (map && !pa_channel_map_parse(&pa_map, map)) {
>>> +        dolog("Invalid channel map specified: '%s'\n", map);
>>> +        map =3D NULL;
>>> +    }
>>> +    if (!map) {
>>> +        pa_channel_map_init_extend(&pa_map, ss->channels,
>>> +                                   PA_CHANNEL_MAP_OSS);
>>> +    }
>>> +
>>> +    stream =3D pa_stream_new(c->context, name, ss, &pa_map);
>>>       if (!stream) {
>>>           goto fail;
>>>       }
>>> @@ -421,7 +431,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct auds=
ettings *as,
>>>           PA_STREAM_PLAYBACK,
>>>           ppdo->has_name ? ppdo->name : NULL,
>>>           &ss,
>>> -        NULL,                   /* channel map */
>>> +        ppdo->has_channel_map ? ppdo->channel_map : NULL,
>>>           &ba,                    /* buffering attributes */
>>>           &error
>>>           );
>>> @@ -470,7 +480,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audset=
tings *as, void *drv_opaque)
>>>           PA_STREAM_RECORD,
>>>           ppdo->has_name ? ppdo->name : NULL,
>>>           &ss,
>>> -        NULL,                   /* channel map */
>>> +        ppdo->has_channel_map ? ppdo->channel_map : NULL,
>>>           &ba,                    /* buffering attributes */
>>>           &error
>>>           );
>>> diff --git a/qapi/audio.json b/qapi/audio.json
>>> index 0535eff794..07003808cb 100644
>>> --- a/qapi/audio.json
>>> +++ b/qapi/audio.json
>>> @@ -214,13 +214,16 @@
>>>   # @latency: latency you want PulseAudio to achieve in microseconds
>>>   #           (default 15000)
>>>   #
>>> +# @channel-map: channel map to use (default: OSS compatible map, since=
: 4.2)
>>> +#
>>>   # Since: 4.0
>>>   ##
>>>   { 'struct': 'AudiodevPaPerDirectionOptions',
>>>     'base': 'AudiodevPerDirectionOptions',
>>>     'data': {
>>> -    '*name': 'str',
>>> -    '*latency': 'uint32' } }
>>> +    '*name':        'str',
>>> +    '*latency':     'uint32',
>>> +    '*channel-map': 'str' } }
>>>     ##
>>>   # @AudiodevPaOptions:
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index 395427422a..f3bc342f98 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -471,6 +471,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>>>       "-audiodev pa,id=3Did[,prop[=3Dvalue][,...]]\n"
>>>       "                server=3D PulseAudio server address\n"
>>>       "                in|out.name=3D source/sink device name\n"
>>> +    "                in|out.channel-map=3D channel map to use\n"
>>>   #endif
>>>   #ifdef CONFIG_AUDIO_SDL
>>>       "-audiodev sdl,id=3Did[,prop[=3Dvalue][,...]]\n"
>>> @@ -636,6 +637,14 @@ Sets the PulseAudio @var{server} to connect to.
>>>   @item in|out.name=3D@var{sink}
>>>   Use the specified source/sink for recording/playback.
>>>   +@item in|out.channel-map=3D@var{map}
>>> +Use the specified channel map.  The default is an OSS compatible
>>> +channel map.  Do not forget to escape commas inside the map:
>>
>> Awkward.
>>
>>> +
>>> +@example
>>> +-audiodev pa,id=3Dexample,sink.channel-map=3Dfront-left,,front-right
>>> +@end example
>>
>> Makes me realize new AudiodevPaPerDirectionOptions member @channel-map
>> is a list encoded in a string.  QAPI heavily frowns upon encoding stuff
>> in strings.  Any reason why you can't (or don't want to) make it
>> ['str']?
>
> Hmm, I don't think it's used too frequently on structs parsed by qapi
> opts visitor. What would be the command line format in that case?
> Something like this?
>
> -audiodev
> pa,id=3Dexample,sink.channel-map=3Dfront-left,sink.channel-map=3Dfront-ri=
ght

Let's talk concepts before details.  I'll get back to this below.

> I think it's simply a string because while conceptually it's a string,
> we don't try to interpret it, we just pass the string to
> pa_channel_map_parse.  Of course we could take a list and instead
> either rebuild the string or reimplement half of pa_channel_map_parse
> by manually calling pa_channel_position_from_string.

Precedence: BlockdevOptionsRbd member @auth-client-required.  Under the
hood, this is Ceph configuration option auth-client-required.
Semantically a list of well-known values.  rados_conf_set() takes it
encoded in a string.  We could have plumbed that straight through QAPI
by making @auth-client-required a 'str'.  Instead, we made it
['RbdAuthMode'].  rbd.c has to encode the list in a string for
rados_conf_set().

Why did we bother?  Besides the dogmatic reason "do not encode stuff in
strings in QAPI", there's a pragmatic one: introspection.
@auth-client-required's type ['RbdAuthMode'] tells exactly what the
acceptable values are.  If Ceph ever grows another mode, QEMU support
for it will be visible in introspection: enum RbdAuthMode will have
another value.

Baking the acceptable modes into QEMU means new modes need a QEMU update
to work.  New modes that just work without a QEMU update feel unlikely.
If we're wrong, and a QEMU update is impractical, you can still work
around the limitation with a Ceph configuration file.

Which of these considerations other than "do not encode in strings"
apply to PA I can't say.

Let's turn the question around: is there any reason to break the "do not
encode in strings" rule other than "it saves a few lines of code"?

> Oh now that I looked again at the pulseaudio docs, channel-map doesn't
> have to be a list, it can be also a "well-known mapping name".

Unambiguous because the well-known mapping names are not valid channel
position list members.

Semantially, this is a disjoint union of well-known mapping names and
channel position lists.

The tools QAPI provides for disjoint unions are union and alternate
types.  In this case, an alternate of 'str' and ['str'] would do.
Well-known mapping names use the 'str' branch, channel position lists
the ['str'] branch.

>>
>>> +
>>>   @end table
>>>     @item -audiodev
>>> sdl,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]

I promised you to get back to command line syntax.

The opts visitor uses repeated keys for lists, just like you guessed.
It supports only a subset of the QAPI types, and has weird magic for
integer lists.

-audiodev actually uses the QObject input visitor, which is more general
and somewhat less magical.  Its CLI syntax for lists is even wordier,
though.  I'd expect something like

    -audiodev pa,id=3Dexample,sink.channel-map.0=3Dfront-left,sink.channel-=
map.1=3Dfront-right

Aside: CLI QAPIfication will have to find a way to accomodate the opts
visitor's syntax and quirks, or break compatibility.

