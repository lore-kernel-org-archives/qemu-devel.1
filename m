Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BD9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 21:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE272467B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 21:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icoKL0Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE272467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwBUP-0005x7-6J
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 16:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iwBTk-0005SR-Dp
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iwBTi-0003v6-0e
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:59:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50832
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iwBTh-0003rR-Ro
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 15:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580158764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m25au9EO/EmQ2fsLXoOwEttFXOwJx3U39NwS2PxDCls=;
 b=icoKL0LuooZBx+4LV4YWcrpGYvs8pteX0n0X0NYMGTzSU5Zl415sDo2woQYBctyQn6xRHQ
 x/Ib/Z79GYPpMiAkBgM9WTnmJpHI/E+vUHLc7+i8Uy3h0gV1jWLjs+rv1R4wtUqSH8eCnF
 tGcpPOFGN4snNHxrzSeXaNPu5UIML80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-hQOErmf7NvWWzDBtm-_nJQ-1; Mon, 27 Jan 2020 15:59:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A97D713E1;
 Mon, 27 Jan 2020 20:59:21 +0000 (UTC)
Received: from [10.18.17.116] (dhcp-17-116.bos.redhat.com [10.18.17.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3108E87026;
 Mon, 27 Jan 2020 20:59:15 +0000 (UTC)
Subject: Re: Making QEMU easier for management tools and applications
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org> <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com> <20200127143505.GD5669@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bd4a2839-69d6-697b-dc07-567ba08ce044@redhat.com>
Date: Mon, 27 Jan 2020 15:59:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200127143505.GD5669@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: hQOErmf7NvWWzDBtm-_nJQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/27/20 9:35 AM, Kevin Wolf wrote:
> Am 24.01.2020 um 10:50 hat Daniel P. Berrang=C3=A9 geschrieben:
>> On Thu, Jan 23, 2020 at 04:07:09PM -0500, John Snow wrote:
>>> Well, sure. The context of this email was qmp-shell though, which is
>>> meant to help facilitate the entry of JSON commands so that you *can*
>>> indeed just forego the CLI/HMP entirely.
>>>
>>> If you are of the opinion that every user of QEMU should be copy/pastin=
g
>>> JSON straight into a socket and we should delete qmp-shell, that's
>>> certainly a fine opinion.
>>
>> I think part of the pain of qmp-shell comes from the very fact that
>> it is trying to be an interactive shell. This points people towards
>> interactively typing in the commands, which is horrific when you get
>> anywhere near the JSON, or even dot-notation traditional commands.
>>
>> If it was just a qmp-client that was single shot, we'd encourage
>> people to create the JSON in a sensible way - vim/emacs/whatever.
>=20
> I don't see how this is sensible. QMP commands are something that I
> reuse even less than VM configurations, so creating a one-off file for
> each would take me a lot more time and I would still have to type the
> same JSON code that I have to type with -qmp stdio.
>=20
> The reason it is and should be an interactive shell is that I'm
> interacting with it. Switching back and forth between a text editor and
> a shell to actually send the command to QEMU would make things only even
> more cumbersome than they already are.
>=20
>> Bash/dash/zsh/$whatever is their interactive shell, with massively
>> more features than qmp-shell. You have command history, autocomplete,
>> conditional and looping constructs, and everything a normal shell
>> offers.
>=20
> If I wanted to program a QMP client, I would use Python. For me,
> conditionals and loops are completely out of scope for a QMP shell. I
> just want an easy way to tell QEMU to do something specific.
>=20
> A command history already exists for qmp-shell. It's better than bash
> because it doesn't mix QMP history with whatever else I do on my
> computer.
>=20
> Autocomplete in qmp-shell doesn't exist, as far as I know, but if
> implemented, it could be a lot more useful than bash completion because
> it could offer key completion based on the QMP schema.
>=20

It does have tab completion for command names, but it does not know
about or remember argument fields. It does not have autocomplete or
typing hints like FiSH or bash ^r.

I would like to change this, actually, by making the docstrings in QAPI
schema a first class citizen of the spec and allowing them to be
introspectable via the socket directly.

(I.e., you can get the list of arguments and the docstrings that
accompany them over the wire so you can display it in the client.)

Problem I'm having with qmp-shell is, like Kevin says below ...

> This is in fact a big part of the problem that qmp-shell really needs to
> solve before it can replace HMP: How to make writing commands at least
> almost as simple as with HMP. If I can just press tab a few times to
> cycle through the available options for the command, that would already
> be a massive improvement over writing JSON manually (which you would
> still have to do with your text-file based approach, without any
> QMP-specific support).
>=20

... I can't figure out how to make writing commands simple.

When you have a "simple" command, the abstraction works OK; you can type
key=3Dval pairs and go about your way.

As soon as you have anything nested, the gossamer-thin illusion is
destroyed. I investigated making this a little easier by adding a parser
that could read directly from stdin and would allow multi-line JSON
inputs as arguments.

(Like the python shell does it, for example: When you have a dictionary
opening brace, it lets you continue to the next line.)

I was a little disheartened that most JSON parsers in python expect to
consume buffered objects and generally consume the entire buffer -- it
didn't seem to play nice with the idea of wanting to parse from STDIN
directly.


So:

- I think qmp-shell is worth having, especially if polished
(autocomplete, docstrings, argument hints, etc).

- Kevin mentioned getting this into the GTK shell. I think that would be
great, as a step to help phase out HMP.

- I think getting rid of HMP is good because I don't care for the idea
of supporting two monitor protocols. One schema, one parser, one truth.

- I do, however, like the idea of having a non-rigorous monitor that
lets us get away with murder when we need to. HMP is useful for
debugging, prototypes and other things where the rigor and permanence of
a QAPI schema feels too burdensome.

- So: maybe a turbocharged qmp-shell can offer some similar kinds of
convenience commands that are build on top of real QMP. Sugar logic and
other fanciful things could be implemented there in qmp-shell as
extensions. You'd get a stock pile of them with your QEMU install that
help you do certain tasks quickly and trivially.

- Given all the above, I am willing to try to save, polish, or re-design
qmp-shell; but am a bit starved for ideas on the syntax... This is why I
was spending a bit of time talking about our flattening to dot syntax,
and other projects related to representing hierarchical data.

Would really love to hear ideas on what a good interactive shell syntax
for a JSON-fueled schema would look like.

Any prior art, other projects, and reading anyone can recommend would be
nice.

> The other part that it needs to solve is how to be available by default
> without specifying anything on the command line. Basically, if I press
> Ctrl-Alt-2, I want to get to a monitor shell. If that shell is
> implemented internally or by an external Python process, I don't mind.
>=20
>> The only strong reason for qmp-shell to be interactive would be if
>> the initial protoocl handshake was too slow. I can't see that being
>> a problem with QMP.
>=20
> Speed would be the least of my concerns. This is about manual use, and
> it already takes me a while to type in my commands.
>=20
>> Example usage:
>>
>> 1. Launch the QEMU runtime for the desired target
>>
>>      $ qemu-runtime-x86_64 myvm.sock
>>
>> 2. Load the configuration to define the VM
>>
>>    $ cat myvm.yaml
>>    commands:
>>      - machine_declare:
>>          name: pc-q35-5.0
>> =09 ...
>>      - blockdev_add:
>>          ...
>>      - device_add:
>>          ...
>>      - blockdev_add:
>>          ...
>>      - device_add:
>>          ...
>>    $ qemu-client myvm.sock myvm.yaml
>>
>>
>> 3. Hotplug a disk
>>
>>    $ cat mynewdisk.yaml
>>    commands:
>>      - blockdev_add:
>>          ...
>>      - device_add:
>>          ...
>>    $ qemu-client myvm.sock mynewdisk.yaml
>>
>>
>> 3. Hotunplug a disk
>>
>>    $ cat myolddisk.yaml
>>    commands:
>>      - device_del:
>>          ...
>>      - blockdev_del:
>>          ...
>>    $ qemu-client myvm.sock myolddisk.yaml
>=20
> Just to compare, this is what the human user oriented flow looks like
> today:
>=20
> 1. qemu-system-x86_64 -M pc-q35-5.0 -drive if=3Dvirtio,... -cdrom ...
>=20
> 2. <Press Ctrl-Alt-2 to get to the HMP shell>
>    (qemu) drive_add ...
>    <Press Ctrl-Alt-1 to get back to the guest>
>=20
> 3. <Press Ctrl-Alt-2 to get to the HMP shell>
>    (qemu) device_del ...
>    <Press Ctrl-Alt-1 to get back to the guest>
>=20
> This is what we're competing with, and honestly I don't see how your
> qemu-runtime-*/qemu-client based flow comes even close to it in terms of
> usability.
>=20
> QMP, JSON and YAML may be nice machine interfaces, but having nice
> machine interfaces doesn't mean that you shouldn't also have something
> that is suitable for humans. qmp-shell is trying to be that, and while
> it leaves much to be desired in its current state, replacing it with
> even more machine-friendly stuff that is cumbersome for humans isn't the
> right answer.
>=20

This is why I have two things I want to do:

Part A:
- Remove the CLI as it exists today*
- Introduce a machine-readable, but human-friendly format, like YAML (or
JSON) that's based directly on QAPI.

Part B:
- Improve qmp-shell such that it provides a sufficient usability layer
on top of QMP
- Make this tool prominent to users; e.g. putting it in the GTK
interface would be nice.
- Reduce prominence of HMP and works towards its removal.

--js


