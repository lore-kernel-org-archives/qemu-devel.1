Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99CEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9509E20708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgQu76HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9509E20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwCr-0008NT-PB
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iuwCF-0007cn-81
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iuwCD-0000sf-1M
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:28:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iuwCC-0000qw-SA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579861692;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpNgUmgdkiaUCOmD792gMkQgXNAs2L5SGd+XNtIBD1U=;
 b=TgQu76HXaV57/myl7X3fRt+fx094lsh3etd3yjddiJ3FRq0KqERiNsqXjzvU2VC5h70QQn
 AFxWZ/x0W0FudP/ckzlSAbDTmoJrps3aG1ZRMta8PJRtpMss7MO9ttFfhZyS+0VO9P7MEv
 ihVZC9H2W0am3OqciftHl0uVO3EZxdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-VNDy7SBSMJ2-E-OzUFW4GQ-1; Fri, 24 Jan 2020 05:27:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D9C91005516;
 Fri, 24 Jan 2020 10:27:57 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60AF65DA75;
 Fri, 24 Jan 2020 10:27:46 +0000 (UTC)
Date: Fri, 24 Jan 2020 10:27:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200124102743.GB824327@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <871rrp474i.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: VNDy7SBSMJ2-E-OzUFW4GQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 24, 2020 at 08:59:41AM +0100, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
>=20
> > On 1/23/20 2:01 PM, Daniel P. Berrang=C3=A9 wrote:
> >> So when configuring objects you'll always provide a JSON/YAML doc.
> >> They've got some clever stuff for updating objects where you can
> >> provide a JSON patch for only the bits which need changing.
> >>=20
> >> When querying/listing objects by default it displays only a small
> >> subset of their config information in a human friendly-ish format.
> >> If you want to see everything then you ask for it in JSON/YAML
> >> format. There's also an expression language that lets you extract
> >> particular pieces of information based on requested properties,
> >> and you can filter the list of objects based on attributes and so
> >> on.
> >>=20
> >> I think it is fair to say the structure of kubernetes object config
> >> is on a par with hierarchical complexity of QEMU. The lack of a simple
> >> human targetted data input format does not appear to have negatively
> >> impacted the adoption of Kubernetes. It is worth questioning why this
> >> is the case, while we feel the human CLI syntax for QEMU is so
> >> critically important to QEMU's future ?
>=20
> I consider human CLI syntax for QEMU a mostly solved *design* problem:
> dotted keys.  It's an unsolved *implementation* problem: the CLI is a
> tangled mess of almost two decades' worth of ideas, and only (some of)
> the latest strands actually use dotted keys infrastructure.  The
> proposed solution is CLI QAPIfication.  Gives us configuration file(s)
> and introspection.
>=20
> Dotted keys are merely yet another concrete syntax.  They're designed to
> satisfy the CLI requirements we have, which include a measure of
> compatibility to what's in the tangled mess.  They're reasonably usable
> for simple stuff, but complex stuff can be too verbose to be readable.
> They can't express all of the abstract syntax.  Tolerable, since they
> provide an escape to JSON.  I recommend programs use the JSON escape
> always.  Awkward for humans due to shell quoting.

I agree that the dotted key syntax is our chosen / solved design
for expressing JSON on the CLI. I would also say that, in retrospect,
this was a incorrect design decision that is one of the key things
responsible for QEMU having a bad reputation for complexity.

We should simply never have tried to invent a way to map the full
hiearchy of JSON onto the CLI as the result will always be unpleasant.
The dotted notation is the most verbose way to do this type of
configuration, because of the string repetition it requires for
nested structures.

Lets consider how libvirt uses blockdev for a LUKS volume stored
in iSCSI

  $ qemu-system-x86_64 \
  -object secret,id=3Dlibvirt-5-storage-secret0,\
    data=3D9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6j/1=
,\
    keyid=3DmasterKey0,iv=3DAAECAwQFBgcICQoLDA0ODw=3D=3D,format=3Dbase64 \
  -object secret,id=3Dlibvirt-5-format-luks-secret0,\
    data=3D9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6j/1=
,\
    keyid=3DmasterKey0,iv=3DAAECAwQFBgcICQoLDA0ODw=3D=3D,format=3Dbase64 \
  -blockdev '{"driver":"iscsi","portal":"example.org:6000",\
    "target":"iqn.1992-01.com.example:storage","lun":1,"transport":"tcp",\
    "user":"myname","password-secret":"libvirt-5-storage-secret0",\
    "node-name":"libvirt-5-storage","auto-read-only":true,"discard":"unmap"=
}' \
  -blockdev '{"node-name":"libvirt-5-format","read-only":false,"driver":"qc=
ow2",\
    "encrypt":{"format":"luks","key-secret":"libvirt-5-format-luks-secret0"=
},\
    "file":"libvirt-5-storage"}' \

We all know JSON is horrible on the CLI, no surprise. So

Lets use human "friendly" dotted syntax instead:

  $ qemu-system-x86_64 \
  -object secret,id=3Dlibvirt-5-storage-secret0,\
    data=3D9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6j/1=
,\
    keyid=3DmasterKey0,iv=3DAAECAwQFBgcICQoLDA0ODw=3D=3D,format=3Dbase64 \
  -object secret,id=3Dlibvirt-5-format-luks-secret0,\
    data=3D9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6j/1=
,\
    keyid=3DmasterKey0,iv=3DAAECAwQFBgcICQoLDA0ODw=3D=3D,format=3Dbase64 \
  -blockdev driver=3Dqcow2,node-name=3Dlibvirt-5-format,read-only=3Dfalse,\
    encrypt.format=3Dluks,encrypt.key-secret=3Dlibvirt-5-format-luks-secret=
0,\
    file.driver=3Discsi,file.portal=3Dexample.org:6000,\
    file.target=3Diqn.1992-01.com.example:storage,file.lun=3D1,file.transpo=
rt=3Dtcp,\
    file.user=3Dmyname,file.password-secret=3Dlibvirt-6-storage-secret0,\
    file.node-name=3Dlibvirt-5-storage,file.auto-read-only=3Dtrue,file.dica=
rd=3Dunmap

I don't think that's much of an improvement, aside from not having
to worry about matching "}".

If we move to JSON in a config file

  $ cat qemu.json
  {
    "arguments": [
      {
        "arg": "object",
        "data": {
          "type": "secret",
          "id":"libvirt-5-storage-secret0",
          "data": "9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91u=
EHCn6j/1",
          "keyid": "masterKey0",
          "iv": "AAECAwQFBgcICQoLDA0ODw=3D=3D",
          "format": "base64"
        }
      },
      {
        "arg": "object",
        "data": {
          "type": "secret",
          "id":"libvirt-5-format-luks-secret0",
          "data": "9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91u=
EHCn6j/1",
          "keyid": "masterKey0",
          "iv": "AAECAwQFBgcICQoLDA0ODw=3D=3D",
          "format": "base64"
        }
      },
      {
        "arg": "blockdev",
        "data": {
          "node-name":"libvirt-5-format",
          "read-only":false,"driver":"qcow2",
          "encrypt":{
            "format":"luks","key-secret":
            "libvirt-5-format-luks-secret0"
          },
          "file":{
            "driver": "iscsi",
            "portal": "example.org:6000",
            "target":"iqn.1992-01.com.example:storage",
            "lun": 1,
            "transport": "tcp",
            "user": "myname",
            "password-secret": "libvirt-5-storage-secret0",
            "node-name":"libvirt-5-storage",
            "auto-read-only":"true",
            "discard":"unmap"
          }
        }
      }
    ]
  }
  $ qemu-system-x86_64 -f qemu.json

The config file is more volumous than the CLI, but it is also
massively more intelligible to humans because you can see the
structure of the data.

I still screwed up many times with missing quotes, incorrect
commas, etc. All the fun of JSON

So if we allowed YAML instead of JSON, now we get...

  $ cat qemu.yaml
  ---
  arguments:
  - arg: object
    data:
      type: secret
      id: libvirt-5-storage-secret0
      data: 9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6j/=
1
      keyid: masterKey0
      iv: AAECAwQFBgcICQoLDA0ODw=3D=3D
      format: base64
  - arg: object
    data:
      type: secret
      id: libvirt-5-format-luks-secret0
      data: 9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEHCn6j/=
1
      keyid: masterKey0
      iv: AAECAwQFBgcICQoLDA0ODw=3D=3D
      format: base64
  - arg: blockdev
    data:
      node-name: libvirt-5-format
      read-only: false
      driver: qcow2
      encrypt:
        format: luks
        key-secret: libvirt-5-format-luks-secret0
      file:
        driver: iscsi
        portal: example.org:6000
        target: iqn.1992-01.com.example:storage
        lun: 1
        transport: tcp
        user: myname
        password-secret: libvirt-5-storage-secret0
        node-name: libvirt-5-storage
        auto-read-only: true
        discard: unmap
  $ qemu-system-x86_64 -f qemu.yaml

This is finally something I'd consider to be on a par with the
original QEMU syntax, before we added hierarchical data. You
have the minimal possible amount of syntax here. No commas,
no quotes, no curly brackets, etc.

I'm sure there are things about YAML that are not nice, but
at some point there's a tradeoff where we can declare it
"good enough". You mention that it has a huge design spec,
but does that really matter ? We shouldn't be implemneting
a parser or formatter ourselves, just re-use one that
already exists. What matters more is whether it is nice
for humans & machines, and I think it is a good syntax
in both those cases.


> > However, the docs being badly out of date are a problem. We actively
> > lead people towards harmful / difficult to support paradigms.
> >
> >> All this results in a situation where JSON is functionally the best
> >> way to configure QEMU, but practically the worse, since very few
> >> people understand how to actually use it. This is a vicious circle
> >> holding back QMP/JSON and making the human syntax an ever greater
> >> burden for users & maintainers
> >>=20
> >
> > I do basically agree.
>=20
> What to do about it?
>=20
> Here's an idea that hasn't been mentioned in this thread: a -writeconfig
> that actually works.  After you configured QEMU in whatever ways you
> rustled up on the 'net, you can -writeconfig the resulting command line
> into a *modern* configuration file.

No matter what we do implementation / designwise, the pre-requisite for
all of them is that we're able to fully express the configuration of the
VM using QAPI. As a side effect this means that -loadconfig and -writeconfi=
g
become usable in the real world, which is nice for the current users of
qemu-system-XXX.  Per my reply to John though, I think we could consider
being more ambituous & seek to obslete qemu-system-XXX entirely at some
point in the future.

> >> IOW, the difficulty with configuring QEMU via JSON is not the fault
> >> of JSON itself, it is the lack of knowledge amongst users and docs,
> >> compounded by our never ending "improvements" to the human syntax.
> >> There are other factors too, such as our only partial coverage of
> >> config using JSON - some is only possible via the CLI still.
> >
> > I'm fine with getting rid of HMP entirely, I think. It's a weird
> > interface with bizarre behavior that's hard to support.
> >
> > There's a few commands in there we just don't support at all, but maybe
> > it's time to start deprecating one-by-one any of the individual command=
s
> > that are better served by QMP these days, to send the message that HMP'=
s
> > days are numbered.
> >
> > Bye-bye!
>=20
> Experience tells that no matter how weird and bizarre a feature is, once
> you attempt to remove it, it *will* find champions willing to fight for
> it to the death.  I'm not trying to tell you "don't go there", only "if
> you go there, go armed and prepared".

Yeah and it gets worse the older / more mature a project is. This
is what pushes projects into doing a clean break "2.0" design,
which is something we've never done for QEMU.  I don't mean just
breaking backcompat in a handful of CLI args here. I mean a proper
scorched earth, everything is up for re-evaluation, "2.0".


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


