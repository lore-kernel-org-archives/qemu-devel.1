Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8402C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521FA2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521FA2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIeBf-0002Im-9z
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 15:01:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIeAQ-0001Zh-As
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 14:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIeAJ-0000Vr-Ae
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 14:59:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hIeA2-00008r-HJ; Mon, 22 Apr 2019 14:59:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 870A730821DF;
	Mon, 22 Apr 2019 18:59:09 +0000 (UTC)
Received: from [10.18.17.206] (dhcp-17-206.bos.redhat.com [10.18.17.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F30FD608E4;
	Mon, 22 Apr 2019 18:59:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190418001413.32627-1-jsnow@redhat.com>
	<5da294b5-b0d7-2ec2-7fa7-f69c6c4f220a@virtuozzo.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <7759715c-9013-5b84-f5b4-929b536d9ee0@redhat.com>
Date: Mon, 22 Apr 2019 14:59:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5da294b5-b0d7-2ec2-7fa7-f69c6c4f220a@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 22 Apr 2019 18:59:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] docs/interop/bitmaps: rewrite and
 modernize doc
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
Cc: Fam Zheng <fam@euphon.net>, Aihua Liang <aliang@redhat.com>,
	"kchamart@redhat.com" <kchamart@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>, Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422185907.A6vmpz_qdCBiusB7M394MLq5WznL0aX5wddpJ7Gvrpg@z>



On 4/18/19 12:38 PM, Vladimir Sementsov-Ogievskiy wrote:
> 18.04.2019 3:14, John Snow wrote:
>> This just about rewrites the entirety of the bitmaps.rst document to
>> make it consistent with the 4.0 release. I have added new features see=
n
>> in the 4.0 release, as well as tried to clarify some points that keep
>> coming up when discussing this feature both in-house and upstream.
>>
>> Yes, it's a lot longer, mostly due to examples. I get a bit chatty.
>> I could use a good editor to help reign in my chattiness.
>>
>> It does not yet cover pull backups or migration details, but I intend =
to
>> keep extending this document to cover those cases.
>>
>> Please try compiling it with sphinx and look at the rendered output, I
>> don't have hosting to share my copy at present. I think this new layou=
t
>> reads nicer in the HTML format than the old one did, at the expense of
>> looking less readable in the source tree itself (though not completely
>> unmanagable. We did decide to convert it from Markdown to ReST, after
>> all, so I am going all-in on ReST.)
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   docs/interop/bitmaps.rst | 1499 ++++++++++++++++++++++++++++++------=
--
>>   Makefile                 |    2 +-
>>   2 files changed, 1192 insertions(+), 309 deletions(-)
>>
>> diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
>> index 7bcfe7f461..a39d1fc871 100644
>> --- a/docs/interop/bitmaps.rst
>> +++ b/docs/interop/bitmaps.rst
>=20
> you may want to update copyright date at the beginning of the file
>=20

Ah, I guess so. I don't really know how copyright works anyway :)

>> @@ -9,128 +9,481 @@
>>   Dirty Bitmaps and Incremental Backup
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  =20
>> --  Dirty Bitmaps are objects that track which data needs to be backed=
 up
>> -   for the next incremental backup.
>> +Dirty Bitmaps are in-memory objects that track writes to block device=
s. They can
>> +be used in conjunction with various block job operations to perform i=
ncremental
>> +or differential backup regimens.
>>  =20
>> --  Dirty bitmaps can be created at any time and attached to any node
>> -   (not just complete drives).
>> +This document explains the conceptual mechanisms, as well as up-to-da=
te,
>> +complete and comprehensive documentation on the API to manipulate the=
m.
>> +(Hopefully, the "why", "what", and "how".)
>> +
>> +The intended audience for this document is developers who are adding =
QEMU backup
>> +features to management applications, or power users who run and admin=
ister QEMU
>> +directly via QMP.
>>  =20
>>   .. contents::
>>  =20
>> +Overview
>> +--------
>> +
>> +Bitmaps are bit vectors where each '1' bit in the vector indicates a =
modified
>> +("dirty") segment of the corresponding block device. The size of the =
segment
>> +that is tracked is the granularity of the bitmap. If the granularity =
of a bitmap
>> +is 64K, each '1' bit means that an entire 64K region changed in some =
way.
>=20
> hm not exactly. =D0=A1onversely, if we change not the entire region but=
 only on byte of it,
> corresponding bit in the bitmap would be set..
>=20

Ah, yeah, I worded this oddly. I meant to say that taken as a whole, a
64k region changed in some way (possibly by as little as just one bit.)

I'll fix this.

>> +
>> +Smaller granularities mean more accurate tracking of modified disk da=
ta, but
>> +requires more computational overhead and larger bitmap sizes. Larger
>> +granularities mean smaller bitmap sizes, but less targeted backups.
>> +
>> +The size of a bitmap (in bytes) can be computed as such:
>> +    ``size`` =3D ((``image_size`` / ``granularity``) / 8)
>=20
> both divisions should round up
>=20

Will clarify. It's also not quite true because of the hierarchical
storage requirements too; this is really the size on disk ... but it's a
useful heuristic for people to know, anyway.

"It's about 1MB per 512GB, until you adjust tuning."

>> +
>> +e.g. the size of a 64KiB granularity bitmap on a 2TiB image is:
>> +    ``size`` =3D ((2147483648K / 64K) / 8)
>> +         =3D 4194304B =3D 4MiB.
>> +
>> +QEMU uses these bitmaps when making incremental backups to know which
>> +sections of the file to copy out. They are not enabled by default and
>> +must be explicitly added in order to begin tracking writes.
>> +
>> +Bitmaps can be created at any time and can be attached to any
>> +arbitrary block node in the storage graph, but are most useful
>> +conceptually when attached to the root node attached to the guest's
>> +storage device model.
>> +
>> +(Which is a really chatty way of saying: It's likely most useful to
>> +track the guest's writes to disk, but you could theoretically track
>> +things like qcow2 metadata changes by attaching the bitmap elsewhere
>> +in the storage graph.)
>> +
>> +QEMU supports persisting these bitmaps to disk via the qcow2 image fo=
rmat.
>> +Bitmaps which are stored or loaded in this way are called "persistent=
", whereas
>> +bitmaps that are not are called "transient".
>> +
>> +QEMU also supports the migration of both transient bitmaps (tracking =
any
>> +arbitrary image format) or persistent bitaps (qcow2) via live migrati=
on.
>=20
> s/bitaps/bitmaps
>=20
> not sure it should be mentioned: only named bitmaps are migrated.
>=20

Since anonymous bitmaps ought to be invisible from the QMP api, it's
probably only worth a quick mention in the migration section I intend to
write. It's useful information for QEMU developers, but not really
users, I think.

>> +
>> +Supported Image Formats
>> +-----------------------
>> +
>> +QEMU supports all documented features below on the qcow2 image format=
.
>> +
>> +However, qcow2 is only strictly necessary for the persistence feature=
, which
>> +writes bitmap data to disk upon close. If persistence is not required=
 for a
>> +specific use case, all bitmap features excepting persistence are avai=
lable
>> +for any arbitrary image format.
>> +
>> +For example, Dirty Bitmaps can be combined with the 'raw' image forma=
t,
>> +but any changes to the bitmap will be discarded upon exit.
>> +
>> +.. warning:: Transient bitmaps will not be saved on QEMU exit! Persis=
tent
>> +             bitmaps are available only on qcow2 images.
>> +
>>   Dirty Bitmap Names
>>   ------------------
>>  =20
>> --  A dirty bitmap's name is unique to the node, but bitmaps attached =
to
>> -   different nodes can share the same name.
>> +Bitmap objects need a method to reference them in the API. All API-cr=
eated and
>> +managed bitmaps have a human-readable name chosen by the user at crea=
tion time.
>>  =20
>> --  Dirty bitmaps created for internal use by QEMU may be anonymous an=
d
>> -   have no name, but any user-created bitmaps must have a name. There
>> -   can be any number of anonymous bitmaps per node.
>> +-  A bitmap's name is unique to the node, but bitmaps attached to dif=
ferent
>> +   nodes can share the same name. Therefore, all bitmaps are addresse=
d via their
>> +   (node, name) pair.
>>  =20
>> --  The name of a user-created bitmap must not be empty ("").
>> +-  The name of a user-created bitmap cannot be empty ("").
>>  =20
>> -Bitmap Modes
>> -------------
>> +-  Transient bitmaps can have JSON unicode names that are effectively=
 not length
>> +   limited. (QMP protocol may restrict messages to less than 64MiB.)
>>  =20
>> --  A bitmap can be "frozen," which means that it is currently in-use =
by
>> -   a backup operation and cannot be deleted, renamed, written to, res=
et,
>> -   etc.
>> +-  Persistent storage formats may impose their own requirements on bi=
tmap names
>> +   and namespaces. Presently, only qcow2 supports persistent bitmaps.=
 See
>> +   docs/interop/qcow2.txt for more details on restrictions. Notably:
>>  =20
>> --  The normal operating mode for a bitmap is "active."
>> +   -  qcow2 bitmap names are limited to between 1 and 1023 bytes long=
.
>> +
>> +   -  No two bitmaps saved to the same qcow2 file may share the same =
name.
>> +
>> +-  QEMU occasionally uses bitmaps for internal use which have no name=
. They are
>> +   hidden from API query calls, cannot be manipulated by the external=
 API, and
>> +   are never persistent.
>=20
> and are not migrated
>=20

OK

>> +
>> +Bitmap Status
>> +-------------
>> +
>> +Dirty Bitmap objects can be queried with the QMP command `query-block
>> +<qemu-qmp-ref.html#index-query_002dblock>`_, and are visible via the
>> +`BlockDirtyInfo <qemu-qmp-ref.html#index-BlockDirtyInfo>`_ QAPI struc=
ture.
>> +
>> +This struct shows the name, granularity, and dirty byte count for eac=
h bitmap.
>> +Additionally, it shows several boolean status indicators:
>> +
>> +- ``recording``: This bitmap is recording guest writes.
>=20
> may be not guest writes, but anything like qcow2 metadata, if bitmap is=
 attached not to root.
>=20

Right. I was trying to find a way to succinctly say "writes originating
from this node or higher" ... it's kind of a subtle point, especially
when this document takes no effort to explain what the storage graph is.

(Maybe that's the next document to write?)

>=20
>> +- ``busy``: This bitmap is in-use by an operation.
>> +- ``persistent``: This bitmap is a persistent type.
>> +- ``inconsistent``: This bitmap is corrupted and cannot be used.
>> +
>> +The ``+busy`` status prohibits you from deleting, clearing, or otherw=
ise
>> +modifying a bitmap, and happens when the bitmap is being used for a b=
ackup
>> +operation or is in the process of being loaded from a migration. Many=
 of the
>> +commands documented below will refuse to work on such bitmaps.
>> +
>> +There is also a deprecated
>> +"`DirtyBitmapStatus <qemu-qmp-ref.html#index-DirtyBitmapStatus>`_" fi=
eld. a
>> +bitmap historically had five visible states:
>> +
>> +   #. ``Frozen``: This bitmap is currently in-use by an operation and=
 is
>> +      immutable. It can't be deleted, renamed, reset, etc.
>> +
>> +      (This is now ``+busy``.)
>> +
>> +   #. ``Disabled``: This bitmap is not recording new writes from the =
guest.
>> +
>> +      (This is now ``-recording -busy``.)
>> +
>> +   #. ``Active``: This bitmap is recording new writes from the guest.
>> +
>> +      (This is now ``+recording -busy``.)
>> +
>> +   #. ``Locked``: This bitmap is in-use by an operation, and is immut=
able.
>> +      The difference from "Frozen" was primarily implementation detai=
ls.
>> +
>> +      (This is now ``+busy``.)
>> +
>> +   #. ``Inconsistent``: This persistent bitmap was not saved to disk =
correctly,
>> +      and can no longer be used. It remains in memory to serve as an
>> +      indicator of failure.
>> +
>> +      (This is now ``+inconsistent``.)
>> +
>> +These states are directly replaced by the status indicators and shoul=
d
>> +not be used. The difference between ``Frozen`` and ``Locked`` is an
>> +implementation detail and should not be relevant to external users.
>>  =20
>>   Basic QMP Usage
>>   ---------------
>>  =20
>> +The primary interface to manipulating bitmap objects is via the QMP
>> +interface. If you are not familiar, see docs/interop/qmp-intro.txt fo=
r a broad
>> +overview, and `qemu-qmp-ref <qemu-qmp-ref.html>`_ for a full referenc=
e of all
>> +QMP commands.
>> +
>>   Supported Commands
>>   ~~~~~~~~~~~~~~~~~~
>>  =20
>> +There are six primary bitmap-management API commands:
>> +
>>   - ``block-dirty-bitmap-add``
>>   - ``block-dirty-bitmap-remove``
>>   - ``block-dirty-bitmap-clear``
>> +- ``block-dirty-bitmap-disable``
>> +- ``block-dirty-bitmap-enable``
>> +- ``block-dirty-bitmap-merge``
>>  =20
>> -Creation
>> -~~~~~~~~
>> +And one related query command:
>>  =20
>> --  To create a new bitmap, enabled, on the drive with id=3Ddrive0:
>> +- ``query-block``
>>  =20
>> -.. code:: json
>> +Creation: block-dirty-bitmap-add
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  =20
>> -    { "execute": "block-dirty-bitmap-add",
>> -      "arguments": {
>> -        "node": "drive0",
>> -        "name": "bitmap0"
>> -      }
>> -    }
>> +`block-dirty-bitmap-add
>> +<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002dadd>`_:
>> +
>> +Creates a new bitmap that tracks writes to the specified node. granul=
arity,
>> +persistence, and recording state can be adjusted at creation time.
>> +
>> +.. admonition:: Example
>> +
>> + to create a new, actively recording persistent bitmap:
>> +
>> + .. code:: json
>> +
>> +  -> { "execute": "block-dirty-bitmap-add",
>> +       "arguments": {
>> +         "node": "drive0",
>> +         "name": "bitmap0",
>> +         "persistent": true,
>> +       }
>> +     }
>> +
>> +  <- { "return": {} }
>>  =20
>>   -  This bitmap will have a default granularity that matches the clus=
ter
>>      size of its associated drive, if available, clamped to between [4=
KiB,
>>      64KiB]. The current default for qcow2 is 64KiB.
>>  =20
>> --  To create a new bitmap that tracks changes in 32KiB segments:
>> +.. admonition:: Example
>>  =20
>> -.. code:: json
>> + To create a new, disabled (``-recording``), transient bitmap that tr=
acks
>> + changes in 32KiB segments:
>>  =20
>> -    { "execute": "block-dirty-bitmap-add",
>> -      "arguments": {
>> -        "node": "drive0",
>> -        "name": "bitmap0",
>> -        "granularity": 32768
>> -      }
>> -    }
>> + .. code:: json
>>  =20
>> -Deletion
>> -~~~~~~~~
>> +  -> { "execute": "block-dirty-bitmap-add",
>> +       "arguments": {
>> +         "node": "drive0",
>> +         "name": "bitmap1",
>> +         "granularity": 32768,
>> +         "disabled": true
>> +       }
>> +     }
>>  =20
>> --  Bitmaps that are frozen cannot be deleted.
>> +  <- { "return": {} }
>>  =20
>> --  Deleting the bitmap does not impact any other bitmaps attached to =
the
>> +Deletion: block-dirty-bitmap-remove
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +`block-dirty-bitmap-remove
>> +<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002dremove>`_:
>> +
>> +Deletes a bitmap. Bitmaps that are ``+busy`` cannot be removed.
>> +
>> +-  Deleting a bitmap does not impact any other bitmaps attached to th=
e
>>      same node, nor does it affect any backups already created from th=
is
>> -   node.
>> +   bitmap or node.
>>  =20
>>   -  Because bitmaps are only unique to the node to which they are
>>      attached, you must specify the node/drive name here, too.
>>  =20
>> -.. code:: json
>> +-  Deleting a persistent bitmap will remove it from the qcow2 file.
>>  =20
>> -    { "execute": "block-dirty-bitmap-remove",
>> -      "arguments": {
>> -        "node": "drive0",
>> -        "name": "bitmap0"
>> -      }
>> -    }
>> +.. admonition:: Example
>>  =20
>> -Resetting
>> -~~~~~~~~~
>> + Remove a bitmap named ``bitmap0`` from node ``drive0``:
>>  =20
>> --  Resetting a bitmap will clear all information it holds.
>> + .. code:: json
>> +
>> +  -> { "execute": "block-dirty-bitmap-remove",
>> +       "arguments": {
>> +         "node": "drive0",
>> +         "name": "bitmap0"
>> +       }
>> +     }
>> +
>> +  <- { "return": {} }
>> +
>> +Resetting: block-dirty-bitmap-clear
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +`block-dirty-bitmap-clear
>> +<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002dclear>`_:
>> +
>> +Clears all dirty bits from a bitmap. ``+busy`` bitmaps cannot be clea=
red.
>>  =20
>>   -  An incremental backup created from an empty bitmap will copy no d=
ata,
>>      as if nothing has changed.
>>  =20
>> -.. code:: json
>> -
>> -    { "execute": "block-dirty-bitmap-clear",
>> -      "arguments": {
>> -        "node": "drive0",
>> -        "name": "bitmap0"
>> -      }
>> -    }
>> +.. admonition:: Example
>> +
>> + Clear all dirty bits from bitmap ``bitmap0`` on node ``drive0``:
>> +
>> + .. code:: json
>> +
>> +  -> { "execute": "block-dirty-bitmap-clear",
>> +       "arguments": {
>> +         "node": "drive0",
>> +         "name": "bitmap0"
>> +       }
>> +     }
>> +
>> +  <- { "return": {} }
>> +
>> +Enabling: block-dirty-bitmap-enable
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +`block-dirty-bitmap-enable
>> +<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002denable>`_:
>> +
>> +"Enables" a bitmap, setting the ``recording`` bit to true, causing gu=
est writes
>=20
> may be not guest, but any writes to the node
>=20

[OK, I'll look for any time I mention guest writes and try to improve
the wording.]

>> +to begin being recorded. ``+busy`` bitmaps cannot be enabled.
>=20
> hmm, you never mentions that +inconsistent also restrict most of operta=
ions
>=20

It comes quite a bit later, where I suggest that the only valid
operation on an inconsistent bitmap is "remove," but I can try to pay it
some homage here, too.

>> +
>> +- Bitmaps default to being enabled when created, unless configured ot=
herwise.
>> +
>> +- Persistent enabled bitmaps will remember their ``+recording`` statu=
s on load.
>> +
>> +.. admonition:: Example
>> +
>> + To set ``+recording`` on bitmap ``bitmap0`` on node ``drive0``:
>> +
>> + .. code:: json
>> +
>> +  -> { "execute": "block-dirty-bitmap-enable",
>> +       "arguments": {
>> +         "node": "drive0",
>> +         "name": "bitmap0"
>> +       }
>> +     }
>> +
>> +  <- { "return": {} }
>> +
>> +Enabling: block-dirty-bitmap-disable
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +`block-dirty-bitmap-disable
>> +<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002ddisable>`_:
>> +
>> +"Disables" a bitmap, setting the ``recording`` bit to false, causing =
further
>> +guest writes to begin being ignored. ``+busy`` bitmaps cannot be disa=
bled.
>=20
> same comments here
>=20

Worried that there's going to be a lot of this.
(At least I was consistently misleading?)

>> +
>> +.. warning::
>> +
>> +  This is potentially dangerous: QEMU makes no effort to stop any gue=
st writes
>> +  if there are disabled bitmaps on a drive, and will not mark any dis=
abled
>> +  bitmaps as ``+inconsistent`` if any such writes do happen. Backups =
made from
>> +  such bitmaps will not be able to be used to reconstruct a full gues=
t image.
>> +
>> +- Disabling a bitmap may be useful for examining which sectors of a d=
isk changed
>> +  during a specific time period, or for explicit management of differ=
ential
>> +  backup windows.
>> +
>> +- Persistent disabled bitmaps will remember their ``-recording`` stat=
us on load.
>> +
>> +.. admonition:: Example
>> +
>> + To set ``-recording`` on bitmap ``bitmap0`` on node ``drive0``:
>> +
>> + .. code:: json
>> +
>> +  -> { "execute": "block-dirty-bitmap-disable",
>> +       "arguments": {
>> +         "node": "drive0",
>> +         "name": "bitmap0"
>> +       }
>> +     }
>> +
>> +  <- { "return": {} }
>> +
>> +Merging, Copying: block-dirty-bitmap-merge
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +`block-dirty-bitmap-merge
>> +<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002dmerge>`_:
>> +
>> +Merges one or more bitmaps into a target bitmap. For any segment that=
 is dirty
>> +in any one source bitmap, the target bitmap will mark that segment di=
rty.
>> +
>> +- Merge takes one or more bitmaps as a source and copies them into a =
single
>> +  destination.
>=20
> disagree with term "copies" here.. copy is not merge.
>=20

Hm... yeah, I will change this phrasing.

>> +
>> +- Merge does not create the destination bitmap if it does not exist. =
A blank
>> +  bitmap can be created beforehand to achieve the same effect.
>=20
> (hmm, interesting, may be we want to add such a feature)
>=20

It might make things one command easier in general, but also prohibits
you from doing things like setting the persistence bit.

I'm fairly ambivalent about this one in particular, but... maybe.

>> +
>> +- The destination is not cleared prior to merge, so subsequent merge =
operations
>> +  will continue to cumulatively mark more segments as dirty.
>> +
>> +- If the merge operation should fail, the destination bitmap is guara=
nteed to be
>> +  unmodified. The operation may fail if the source or destination bit=
maps are
>> +  busy, or have different granularities.
>> +
>> +- Bitmaps can only be merged on the same node. There is only one "nod=
e"
>> +  argument, so all bitmaps must be attached to that same node.
>> +
>> +- Copy can be achieved by merging from a single source to an empty de=
stination.
>> +
>> +.. admonition:: Example
>> +
>> + Merge the data from ``bitmap0`` into the bitmap ``new_bitmap`` on no=
de
>> + ``drive0``. If ``new_bitmap`` was empty prior to this command, this =
achieves a
>> + copy.
>> +
>> + .. code:: json
>> +
>> +  -> { "execute": "block-dirty-bitmap-merge",
>> +       "arguments": {
>> +         "node": "drive0",
>> +         "target": "new_bitmap",
>> +         "bitmaps: [ "bitmap0" ]
>> +       }
>> +     }
>> +
>> +  <- { "return": {} }
>> +
>> +Querying: query-block
>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +`query-block
>> +<qemu-qmp-ref.html#index-query_002dblock>`_:
>> +
>> +Not strictly a bitmaps command, but will return information about any=
 bitmaps
>> +attached to nodes serving as the root for guest devices.
>=20
> not for all nodes?
>=20

It doesn't, no. This needs some attention for 4.1 actually. If you look
at test 124, when I expanded that test to cover the new status bits,I
ran into difficulty querying the nodes that weren't attached to device
models.

I want to add a block-dirty-bitmap-query command that just simply and
straightforwardly returns all of the bitmaps, by node...

Also, it's odd that query-block lists them by device instead of by
*node*... I believe there is a query-named-block-nodes that perhaps I
could augment with Bitmap Info, but this might impact the query-block
mechanism...

Anyway, I'll be working on this soon.

>> +
>> +- The "inconsistent" bit will not appear when it is false, appearing =
only when
>> +  the value is true to indicate there is a problem.
>> +
>> +.. admonition:: Example
>> +
>> + Query the block sub-system of QEMU. The following json has trimmed i=
rrelevant
>> + keys from the response to highlight only the bitmap-relevant portion=
s of the
>> + API. This result highlights a bitmap ``bitmap0`` attached to the roo=
t node of
>> + device ``drive0``.
>> +
>> + .. code:: json
>> +
>> +  -> {
>> +       "execute": "query-block",
>> +       "arguments": {}
>> +     }
>> +
>> +  <- {
>> +       "return": [ {
>> +         "dirty-bitmaps": [ {
>> +           "status": "active",
>> +           "count": 0,
>> +           "busy": false,
>> +           "name": "bitmap0",
>> +           "persistent": false,
>> +           "recording": true,
>> +           "granularity": 65536
>> +         } ],
>> +         "device": "drive0",
>> +       } ]
>> +     }
>> +
>> +Bitmap Persistence
>> +------------------
>> +
>> +As outlined in `Supported Image Formats`_, QEMU can persist bitmaps t=
o qcow2
>> +files. Demonstrated in `Creation: block-dirty-bitmap-add`_, passing
>> +``persistent: true`` to ``block-dirty-bitmap-add`` will persist that =
bitmap to
>> +disk.
>> +
>> +Persistent bitmaps will be automatically loaded into memory upon load=
, and will
>> +be written back to disk upon close. Their usage should be mostly tran=
sparent.
>> +
>> +However, if QEMU does not get a chance to close the file cleanly, the=
 bitmap
>> +will be marked as ``+inconsistent`` and considered unsafe to use for =
any
>> +operation. At this point, the only valid operation on such bitmaps is
>> +``block-dirty-bitmap-remove``.
>=20
> Not exactly. If we failed to save bitmap, than we will not clear IN_USE=
 bit from qcow2
> for this bitmap, and on _next_ load qemu will mark the bitmap as ``+inc=
onsistent``.
>=20

Welllll. Right, it's actually already been marked, but that's an
implementation detail. From the point of view of the user, the
+inconsistent flag shows up on next boot.

I can clarify that it's on the *next* boot that this shows up; but
there's little room for QEMU to do any such marking as its busy
segfaulting or aborting :)

>> +
>> +Losing a bitmap in this way does not invalidate any existing bitmaps =
that have
>> +been made, but no further backups will be able to be issued for this =
chain.
>=20
> And you said nothing about any chains before.. Oh, it sounds better whe=
n I understand
> that s/existing bitmaps/existing backups/
>=20

Ah, yes. Existing backups, not bitmaps.

>>  =20
>>   Transactions
>>   ------------
>>  =20
>> +Transactions are a QMP feature that allows you to submit multiple QMP=
 commands
>> +at once, being guaranteed that they will all succeed or fail atomical=
ly,
>> +together. The interaction of bitmaps and transactions are demonstrate=
d below.
>> +
>> +See `transaction <qemu-qmp.ref.html#index-transaction>`_ in the QMP r=
eference
>> +for more details.
>> +
>>   Justification
>>   ~~~~~~~~~~~~~
>>  =20
>> -Bitmaps can be safely modified when the VM is paused or halted by usi=
ng
>> -the basic QMP commands. For instance, you might perform the following
>> -actions:
>> +Bitmaps can generally be modified at any time, but certain operations=
 often only
>> +make sense when paired directly with other commands. When a VM is pau=
sed, it's
>> +easy to ensure that no guest writes occur between individual QMP comm=
ands. When
>> +a VM is running, this is difficult to accomplish with individual QMP =
commands
>> +that may allow guest writes to occur inbetween each command.
>>  =20
>> -1. Boot the VM in a paused state.
>> -2. Create a full drive backup of drive0.
>> -3. Create a new bitmap attached to drive0.
>> -4. Resume execution of the VM.
>> -5. Incremental backups are ready to be created.
>> +For example, using only individual QMP commands, we could:
>> +
>> +#. Boot the VM in a paused state.
>> +#. Create a full drive backup of drive0.
>> +#. Create a new bitmap attached to drive0, confident that nothing has=
 been
>> +   written to drive0 in the meantime.
>> +#. Resume execution of the VM.
>> +#. At a later point, issue incremental backups from ``bitmap0``.
>>  =20
>>   At this point, the bitmap and drive backup would be correctly in syn=
c,
>>   and incremental backups made from this point forward would be correc=
tly
>> @@ -140,416 +493,946 @@ This is not particularly useful if we decide w=
e want to start
>>   incremental backups after the VM has been running for a while, for w=
hich
>>   we will need to perform actions such as the following:
>>  =20
>> -1. Boot the VM and begin execution.
>> -2. Using a single transaction, perform the following operations:
>> +#. Boot the VM and begin execution.
>> +#. Using a single transaction, perform the following operations:
>>  =20
>>      -  Create ``bitmap0``.
>>      -  Create a full drive backup of ``drive0``.
>>  =20
>> -3. Incremental backups are now ready to be created.
>> +#. At a later point, issue incremental backups from ``bitmap0``.
>=20
>=20
> Interesting will it work just without a transaction, create bitmap firs=
t, and then full backup?
> If we'll have any intermediate writes, they will increase extra data in=
 first incremental backup
> bit it is not wrong. I only doubt about some unfinished requests.. Does=
 transaction give us
> drained point and do we really need it?
>=20

Ah, you know... you're right. It will be just extra data and not
"wrong". I guess I wanted to encourage "good habits" with being careful
about the time slices.

...but you ARE right.

I wonder if it's worth clarifying this, or if that's just more confusing.=
..

(By the way, I want to send a patch that allows you to specify a bitmap
with sync=3Dfull that clears the bitmap upon completion, as a convenience=
.
I think it's not very hard to add.)

>>  =20
>>   Supported Bitmap Transactions
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  =20
>>   -  ``block-dirty-bitmap-add``
>>   -  ``block-dirty-bitmap-clear``
>> +-  ``block-dirty-bitmap-enable``
>> +-  ``block-dirty-bitmap-disable``
>> +-  ``block-dirty-bitmap-merge``
>>  =20
>> -The usages are identical to their respective QMP commands, but see be=
low
>> -for examples.
>> +The usages for these commands are identical to their respective QMP c=
ommands,
>> +but see the examples in the sections below for concrete examples.
>=20
> see examples for examples
>=20

LOL.

>>  =20
>> -Example: New Incremental Backup
>> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +Incremental Backups - Push Model
>> +--------------------------------
>>  =20
>> -As outlined in the justification, perhaps we want to create a new
>> -incremental backup chain attached to a drive.
>> +Incremental backups are simply partial disk images that can be combin=
ed with
>> +other partial disk images on top of a base image to reconstruct a ful=
l backup
>> +from the point in time at which the incremental backup was issued.
>>  =20
>> -.. code:: json
>> +The "Push Model" here references the fact that QEMU is "pushing" the =
modified
>> +blocks out to a destination. We will be using the `drive-backup
>> +<qemu-qmp-ref.html#index-drive_002dbackup>`_ and `blockdev-backup
>> +<qemu-qmp-ref.html#index-blockdev_002dbackup>`_ QMP commands to creat=
e both
>> +full and incremental backups.
>>  =20
>> -    { "execute": "transaction",
>> -      "arguments": {
>> -        "actions": [
>> -          {"type": "block-dirty-bitmap-add",
>> -           "data": {"node": "drive0", "name": "bitmap0"} },
>> -          {"type": "drive-backup",
>> -           "data": {"device": "drive0", "target": "/path/to/full_back=
up.img",
>> -                    "sync": "full", "format": "qcow2"} }
>> -        ]
>> -      }
>> -    }
>> +Both of these commands are jobs, which have their own QMP API for que=
rying and
>> +management documented in `Background jobs
>> +<qemu-qmp-ref.html#Background-jobs>`_.
>>  =20
>>   Example: New Incremental Backup Anchor Point
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  =20
>> -Maybe we just want to create a new full backup with an existing bitma=
p
>> -and want to reset the bitmap to track the new chain.
>> +As outlined in the Transactions - `Justification`_ section, perhaps w=
e want to
>> +create a new incremental backup chain attached to a drive.
>> +
>> +This example creates a new, full backup of "drive0" and accompanies i=
t with a
>> +new, empty bitmap that records guest writes from this point in time f=
orward.
>> +
>> +.. note:: Any new writes that happen after this command is issued, ev=
en while
>> +          the backup job runs, will be written locally and not to the=
 backup
>> +          destination. These writes will be recorded in the bitmap ac=
cordingly.
>>  =20
>>   .. code:: json
>>  =20
>> -    { "execute": "transaction",
>> -      "arguments": {
>> -        "actions": [
>> -          {"type": "block-dirty-bitmap-clear",
>> -           "data": {"node": "drive0", "name": "bitmap0"} },
>> -          {"type": "drive-backup",
>> -           "data": {"device": "drive0", "target": "/path/to/new_full_=
backup.img",
>> -                    "sync": "full", "format": "qcow2"} }
>> -        ]
>> -      }
>> -    }
>> -
>> -Incremental Backups
>> --------------------
>> -
>> -The star of the show.
>> -
>> -**Nota Bene!** Only incremental backups of entire drives are supporte=
d
>> -for now. So despite the fact that you can attach a bitmap to any
>> -arbitrary node, they are only currently useful when attached to the r=
oot
>> -node. This is because drive-backup only supports drives/devices inste=
ad
>> -of arbitrary nodes.
>> +  -> {
>> +       "execute": "transaction",
>> +       "arguments": {
>> +         "actions": [
>> +           {
>> +             "type": "block-dirty-bitmap-add",
>> +             "data": {
>> +               "node": "drive0",
>> +               "name": "bitmap0"
>> +             }
>> +           },
>> +           {
>> +             "type": "drive-backup",
>> +             "data": {
>> +               "device": "drive0",
>> +               "target": "/path/to/full_backup.qcow2",
>> +               "sync": "full",
>> +               "format": "qcow2"
>> +             }
>> +           }
>> +         ]
>> +       }
>> +     }
>> +
>> +  <- { "return": {} }
>> +
>> +  <- {
>> +       "timestamp": {
>> +         "seconds": 1555436945,
>> +         "microseconds": 179620
>> +       },
>> +       "data": {
>> +         "status": "created",
>> +         "id": "drive0"
>> +       },
>> +       "event": "JOB_STATUS_CHANGE"
>> +     }
>> +
>> +  ...
>> +
>> +  <- {
>> +       "timestamp": {...},
>> +       "data": {
>> +         "device": "drive0",
>> +         "type": "backup",
>> +         "speed": 0,
>> +         "len": 68719476736,
>> +         "offset": 68719476736
>> +       },
>> +       "event": "BLOCK_JOB_COMPLETED"
>> +     }
>> +
>> +  <- {
>> +       "timestamp": {...},
>> +       "data": {
>> +         "status": "concluded",
>> +         "id": "drive0"
>> +       },
>> +       "event": "JOB_STATUS_CHANGE"
>> +     }
>> +
>> +  <- {
>> +       "timestamp": {...},
>> +       "data": {
>> +         "status": "null",
>> +         "id": "drive0"
>> +       },
>> +       "event": "JOB_STATUS_CHANGE"
>> +     }
>> +
>> +A full explanation of the job transition semantics and the JOB_STATUS=
_CHANGE
>> +event are beyond the scope of this document and will be omitted in al=
l
>> +subsequent examples; above, several more events have been omitted for=
 brevity.
>> +
>> +Events above have had their timestamp objects omitted for brevity.
>=20
> ('"timestamp": {...}' is obvious notation, anyway, and a bit in conflic=
t with last
> sentence)
>=20

So just omit this line in your opinion? The old document made no
omissions at all, so I was just trying to be honest about cutting stuff
out that was really not relevant to this presentation.

>> +
>> +.. note:: Subsequent examples will omit all events except BLOCK_JOB_C=
OMPLETED
>> +          except where necessary to illustrate workflow differences.
>> +
>> +          Omitted events and json objects will be represented by elli=
pses:
>> +          ``...``
>> +
>> +Example: Resetting an Incremental Backup Anchor Point
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +If we want to start a new backup chain with an existing bitmap, we ca=
n also use
>> +a transaction to reset the bitmap while making a new full backup:
>> +
>> +.. code:: json
>> +
>> +  -> {
>> +       "execute": "transaction",
>> +       "arguments": {
>> +         "actions": [
>> +         {
>> +           "type": "block-dirty-bitmap-clear",
>> +           "data": {
>> +             "node": "drive0",
>> +             "name": "bitmap0"
>> +           }
>> +         },
>> +         {
>> +           "type": "drive-backup",
>> +           "data": {
>> +             "device": "drive0",
>> +             "target": "/path/to/new_full_backup.qcow2",
>> +             "sync": "full",
>> +             "format": "qcow2"
>> +           }
>> +         }
>> +       ]
>> +     }
>> +   }
>> +
>> +  <- { "return": {} }
>> +
>> +  ...
>> +
>> +  <- {
>> +       "timestamp": {...},
>> +       "data": {
>> +         "device": "drive0",
>> +         "type": "backup",
>> +         "speed": 0,
>> +         "len": 68719476736,
>> +         "offset": 68719476736
>> +       },
>> +       "event": "BLOCK_JOB_COMPLETED"
>> +     }
>> +
>> +  ...
>> +
>> +The result of this example is identical to the first, but we clear an=
 existing
>> +bitmap instead of adding a new one.
>> +
>> +.. tip:: In both of these examples, "bitmap0" is tied conceptually to=
 the
>> +         creation of new, full backups. This relationship is not save=
d or
>> +         remembered by QEMU; it is up to the operator or management l=
ayer to
>> +         remember which bitmaps are associated with which backups.
>>  =20
>>   Example: First Incremental Backup
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  =20
>> -1. Create a full backup and sync it to the dirty bitmap, as in the
>> -   transactional examples above; or with the VM offline, manually cre=
ate
>> -   a full copy and then create a new bitmap before the VM begins
>> -   execution.
>> +#. Create a full backup and sync it to the dirty bitmap using either =
of the two
>> +   example methods above, or, with the VM offline as suggested in the
>> +   Transactions `Justification`_ section, manually create a full copy=
 and then
>> +   create a new bitmap before the VM begins execution.
>=20
> Justification suggested not exactly this, but start in paused mode and =
do full backup.
> So, actually manual copy when VM is offline, then start in pause mode a=
nd create bitmaps,
> then start - is yet another method
>=20

True...

>>  =20
>> -   -  Let's assume the full backup is named ``full_backup.img``.
>> -   -  Let's assume the bitmap you created is ``bitmap0`` attached to
>> +   - Let's assume the full backup is named ``full_backup.qcow2``.
>> +   - Let's assume the bitmap we created is named ``bitmap0``, attache=
d to
>>         ``drive0``.
>>  =20
>> -2. Create a destination image for the incremental backup that utilize=
s
>> +#. Create a destination image for the incremental backup that utilize=
s
>>      the full backup as a backing image.
>>  =20
>>      -  Let's assume the new incremental image is named
>> -      ``incremental.0.img``.
>> +      ``incremental.0.qcow2``:
>>  =20
>>      .. code:: bash
>>  =20
>> -       $ qemu-img create -f qcow2 incremental.0.img -b full_backup.im=
g -F qcow2
>> +       $ qemu-img create -f qcow2 incremental.0.qcow2 \
>> +         -b full_backup.qcow2 -F qcow2
>>  =20
>> -3. Issue the incremental backup command:
>> +#. Issue an incremental backup command:
>>  =20
>>      .. code:: json
>>  =20
>> -       { "execute": "drive-backup",
>> +    -> {
>> +         "execute": "drive-backup",
>>            "arguments": {
>>              "device": "drive0",
>>              "bitmap": "bitmap0",
>> -           "target": "incremental.0.img",
>> +           "target": "incremental.0.qcow2",
>>              "format": "qcow2",
>>              "sync": "incremental",
>>              "mode": "existing"
>>            }
>>          }
>>  =20
>> +    <- { "return": {} }
>> +
>> +    ...
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive0",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 68719476736,
>> +           "offset": 68719476736
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>> +
>> +    ...
>> +
>> +This copies any blocks modified since the full backup was created int=
o the
>> +``incremental.0.qcow2`` file. During the operation, ``bitmap0`` is ma=
rked
>> +``+busy``. If the operation is successful, ``bitmap0`` will be cleare=
d to
>> +reflect the "incremental" backup regimen, which only copies out new c=
hanges
>> +from each incremental backup.
>> +
>> +.. note:: Any new writes that occur after the backup operation starts=
 do not
>> +          get copied to the destination. The backup's "point in time"=
 is when
>> +          the backup starts, not when it ends. These writes are recor=
ded in a
>> +          special bitmap that gets re-added to bitmap0 when the backu=
p ends so
>> +          that the next incremental backup can copy them out.
>> +
>>   Example: Second Incremental Backup
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  =20
>> -1. Create a new destination image for the incremental backup that poi=
nts
>> -   to the previous one, e.g.: ``incremental.1.img``
>> +#. Create a new destination image for the incremental backup that poi=
nts
>> +   to the previous one, e.g.: ``incremental.1.qcow2``
>>  =20
>>      .. code:: bash
>>  =20
>> -       $ qemu-img create -f qcow2 incremental.1.img -b incremental.0.=
img -F qcow2
>> +       $ qemu-img create -f qcow2 incremental.1.qcow2 \
>> +         -b incremental.0.qcow2 -F qcow2
>>  =20
>> -2. Issue a new incremental backup command. The only difference here i=
s
>> +#. Issue a new incremental backup command. The only difference here i=
s
>>      that we have changed the target image below.
>>  =20
>>      .. code:: json
>>  =20
>> -       { "execute": "drive-backup",
>> +    -> {
>> +         "execute": "drive-backup",
>>            "arguments": {
>>              "device": "drive0",
>>              "bitmap": "bitmap0",
>> -           "target": "incremental.1.img",
>> +           "target": "incremental.1.qcow2",
>>              "format": "qcow2",
>>              "sync": "incremental",
>>              "mode": "existing"
>>            }
>>          }
>>  =20
>> -Errors
>> -------
>> +    <- { "return": {} }
>>  =20
>> --  In the event of an error that occurs after a backup job is
>> -   successfully launched, either by a direct QMP command or a QMP
>> -   transaction, the user will receive a ``BLOCK_JOB_COMPLETE`` event =
with
>> -   a failure message, accompanied by a ``BLOCK_JOB_ERROR`` event.
>> +    ...
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive0",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 68719476736,
>> +           "offset": 68719476736
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>> +
>> +    ...
>> +
>> +Because the first incremental backup from the previous example comple=
ted
>> +successfully, ``bitmap0`` was synchronized with ``incremental.0.qcow2=
``. Here,
>> +we use ``bitmap0`` again to create a new incremental backup that targ=
ets the
>> +previous one, creating a chain of three images:
>> +
>> +.. admonition:: Diagram
>> +
>> + .. code:: text
>> +
>> +   +--------+   +---------------+   +---------------+
>> +   |        |   |               |   |               |
>> +   |  base  +<--+ incremental.0 +<--+ incremental.1 |
>> +   |        |   |               |   |               |
>> +   +--------+   +---------------+   +---------------+
>> +
>> +Each new incremental backup re-synchronizes the bitmap to the latest =
backup
>> +authored, allowing a user to continue to "consume" it to create new b=
ackups
>> +on top of an existing chain.
>> +
>> +In the above diagram, incremental.1 represents incremental.1.qcow2; i=
t is not a
>> +complete image by itself but relies on backing files to reconstruct a=
 full
>> +image. incremental.0 similarly requires the full base image to recons=
truct a
>> +functioning image.
>> +
>> +Each backup in this chain remains independent, and is unchanged by ne=
w entries
>> +made later in the chain. For instance, incremental.0 remains a perfec=
tly valid
>> +backup of the disk as it was when the backup was issued.
>> +
>> +Example: Incremental Push Backups without Backing Files
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Backup images are best kept off-site, so we often will not have the p=
receding
>> +backups in a chain available to link against. This is not a problem a=
t backup
>> +time; we simply do not set the backing image when creating the destin=
ation
>> +image:
>> +
>> +#. Create a new destination image with no backing file set. We will n=
eed to
>> +   specify the size of the base image this time, because it isn't ava=
ilable for
>> +   QEMU to use to guess:
>=20
> or just drop "mode: existing"
>=20

Usually true; but you lose control over the compatibility flags and such
which I am glossing over entirely here. We usually advocate for people
to make the destination images directly because the facilities to
auto-create the image on demand are not consistently great.

Eh, maybe I'm being overcautious and it's fine. It's how this document
*was* written in the past, so I didn't attempt to change it.

>> +
>> +   .. code:: bash
>> +
>> +       $ qemu-img create -f qcow2 incremental.2.qcow2 64G
>> +
>> +#. Issue a new incremental backup command. Apart from the new destina=
tion image,
>> +   there is no difference from the last two examples.
>> +
>> +   .. code:: json
>> +
>> +    -> {
>> +         "execute": "drive-backup",
>> +         "arguments": {
>> +           "device": "drive0",
>> +           "bitmap": "bitmap0",
>> +           "target": "incremental.2.qcow2",
>> +           "format": "qcow2",
>> +           "sync": "incremental",
>> +           "mode": "existing"
>> +         }
>> +       }
>> +
>> +    <- { "return": {} }
>> +
>> +    ...
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive0",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 68719476736,
>> +           "offset": 68719476736
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>> +
>> +    ...
>> +
>> +The only difference from the perspective of the user is that you will=
 need to
>> +set the backing image when attempting to restore the backup:
>> +
>> +.. code:: bash
>> +
>> +    $ qemu-img rebase incremental.2.qcow2 \
>> +      -u -b incremental.1.qcow2
>> +
>> +This uses the "unsafe" rebase mode to simply set the backing file to =
a file that
>> +isn't present.
>=20
> or just instruct use --image-opts to specify the whole backing chain by=
 hand for
> qemu-img convert or qemu-nbd (which is used for restore)
>=20

Ah, yeah. I can try to expand on that.

>> +
>> +Example: Multi-drive Incremental Backup
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Assume we have a VM with two drives, "drive0" and "drive1" and we wis=
h to back
>> +both of them up such that the two backups represent the same crash-co=
nsistent
>> +point in time.
>> +
>> +#. For each drive, create an empty image:
>> +
>> +   .. code:: bash
>> +
>> +    $ qemu-img create -f qcow2 drive0.full.qcow2 64G
>> +    $ qemu-img create -f qcow2 drive1.full.qcow2 64G
>> +
>> +#. Create a full (anchor) backup for each drive, with accompanying bi=
tmaps:
>> +
>> +   .. code:: json
>> +
>> +    -> {
>> +         "execute": "transaction",
>> +         "arguments": {
>> +           "actions": [
>> +             {
>> +               "type": "block-dirty-bitmap-add",
>> +               "data": {
>> +                 "node": "drive0",
>> +                 "name": "bitmap0"
>> +               }
>> +             },
>> +             {
>> +               "type": "block-dirty-bitmap-add",
>> +               "data": {
>> +                 "node": "drive1",
>> +                 "name": "bitmap0"
>> +               }
>> +             },
>> +             {
>> +               "type": "drive-backup",
>> +               "data": {
>> +                 "device": "drive0",
>> +                 "target": "/path/to/drive0.full.qcow2",
>> +                 "sync": "full",
>> +                 "format": "qcow2"
>> +               }
>> +             },
>> +             {
>> +               "type": "drive-backup",
>> +               "data": {
>> +                 "device": "drive1",
>> +                 "target": "/path/to/drive1.full.qcow2",
>> +                 "sync": "full",
>> +                 "format": "qcow2"
>> +               }
>> +             }
>> +           ]
>> +         }
>> +       }
>> +
>> +    <- { "return": {} }
>> +
>> +    ...
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive0",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 68719476736,
>> +           "offset": 68719476736
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>> +
>> +    ...
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive1",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 68719476736,
>> +           "offset": 68719476736
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>> +
>> +    ...
>> +
>> +#. Later, create new destination images for each of the incremental b=
ackups
>> +   that point to their respective full backups:
>> +
>> +   .. code:: bash
>> +
>> +     $ qemu-img create -f qcow2 drive0.inc0.qcow2 \
>> +       -b drive0.full.qcow2 -F qcow2
>> +     $ qemu-img create -f qcow2 drive1.inc0.qcow2 \
>> +       -b drive1.full.qcow2 -F qcow2
>> +
>> +#. Issue a multi-drive incremental push backup transaction:
>> +
>> +   .. code:: json
>> +
>> +    -> {
>> +         "execute": "transaction",
>> +         "arguments": {
>> +           "actions": [
>> +             {
>> +               "type": "drive-backup",
>> +               "data": {
>> +                 "device": "drive0",
>> +                 "bitmap": "bitmap0",
>> +                 "format": "qcow2",
>> +                 "mode": "existing",
>> +                 "sync": "incremental",
>> +                 "target": "drive0.inc0.qcow2"
>> +               }
>> +             },
>> +             {
>> +               "type": "drive-backup",
>> +               "data": {
>> +                 "device": "drive1",
>> +                 "bitmap": "bitmap0",
>> +                 "format": "qcow2",
>> +                 "mode": "existing",
>> +                 "sync": "incremental",
>> +                 "target": "drive1.inc0.qcow2"
>> +               }
>> +             },
>> +           ]
>> +         }
>> +       }
>> +
>> +    <- { "return": {} }
>> +
>> +    ...
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive0",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 68719476736,
>> +           "offset": 68719476736
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>> +
>> +    ...
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive1",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 68719476736,
>> +           "offset": 68719476736
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>> +
>> +    ...
>> +
>> +Push Backup Errors & Recovery
>> +-----------------------------
>> +
>> +-  In the event of an error that occurs after a push backup job is su=
ccessfully
>> +   launched, either by a direct QMP command or a QMP transaction, the=
 user will
>> +   receive a ``BLOCK_JOB_COMPLETE`` event with a failure message, acc=
ompanied by
>> +   a ``BLOCK_JOB_ERROR`` event.
>>  =20
>>   -  In the case of an event being cancelled, the user will receive a
>=20
> s/event/job
>=20

Whoops!

>> -   ``BLOCK_JOB_CANCELLED`` event instead of a pair of COMPLETE and ER=
ROR
>> -   events.
>> +   ``BLOCK_JOB_CANCELLED`` event instead of a pair of COMPLETE and ER=
ROR events.
>>  =20
>> --  In either case, the incremental backup data contained within the
>> -   bitmap is safely rolled back, and the data within the bitmap is no=
t
>> -   lost. The image file created for the failed attempt can be safely
>> -   deleted.
>> +-  In either failure case, the bitmap used for the failed operation i=
s not
>> +   cleared. It will contain all of the dirty bits it did at the start=
 of the
>> +   operation, plus any new bits that got marked during the operation.
>>  =20
>> --  Once the underlying problem is fixed (e.g. more storage space is
>> -   freed up), you can simply retry the incremental backup command wit=
h
>> -   the same bitmap.
>> +-  Effectively, the "point in time" that a bitmap is recording differ=
ences
>> +   against is rolled back to the issuance of the last successful incr=
emental
>> +   backup, instead of being moved forward to the start of this now-fa=
iled
>> +   backup.
>=20
> rolled back instead of being moved forward sounds strange.
>=20
> If we are not moving forward then nothing to roll back.
>=20
> For me it would be clearer something like this:
>=20
> Effectively, everything works like there was no failed backup at all an=
d you can
> safely retry the operation using same dirty bitmap (except you have to =
remove target
> image).
>=20

You're right, "rolled back" is not the right term here. I will rethink
this explanation to avoid those terms.

>=20
>=20
> hmm, noticed just now, that you stopped using ".. admonition::" section=
s for examples...
> also, it would simpler to review, if style changes and paragraph reflow=
 go in separate
> patch..
>=20

Yeah, sorry! I used the example boxes in the section with QMP usage, but
used only code boxes in these sections where the entire purpose of each
section is an example broken up into parts.

If you create an "Example: " box here, and then put the list inside of
it, and then code boxes inside of THAT, it looks much worse.

It's going to be a little difficult to split style refactoring from this
changeset now, so unfortunately I will ask that we consider both for now.

>>  =20
>> -Example
>> -~~~~~~~
>> +-  Once the underlying problem is addressed (e.g. more storage space =
is
>> +   allocated on the destination), the incremental backup command can =
be retried
>> +   with the same bitmap.
>>  =20
>> -1. Create a target image:
>> +Example: Individual Failures
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Backup jobs that fail individually behave simply as described above. =
This
>> +example shows the simplest case:
>> +
>> +#. Create a target image:
>>  =20
>>      .. code:: bash
>>  =20
>> -       $ qemu-img create -f qcow2 incremental.0.img -b full_backup.im=
g -F qcow2
>> +       $ qemu-img create -f qcow2 incremental.0.qcow \
>> +         -b full_backup.qcow -F qcow2
>>  =20
>> -2. Attempt to create an incremental backup via QMP:
>> +#. Attempt to create an incremental backup via QMP:
>>  =20
>>      .. code:: json
>>  =20
>> -       { "execute": "drive-backup",
>> +    -> {
>> +         "execute": "drive-backup",
>>            "arguments": {
>>              "device": "drive0",
>>              "bitmap": "bitmap0",
>> -           "target": "incremental.0.img",
>> +           "target": "incremental.0.qcow2",
>>              "format": "qcow2",
>>              "sync": "incremental",
>>              "mode": "existing"
>>            }
>>          }
>>  =20
>> -3. Receive an event notifying us of failure:
>> +    <- { "return": {} }
>> +
>> +   Note that the job is successfully accepted.
>> +
>> +3. Receive an event indicating failure:
>=20
> s/3/# , and later several times
>=20

Ah, good spot.

>>  =20
>>      .. code:: json
>>  =20
>> -       { "timestamp": { "seconds": 1424709442, "microseconds": 844524=
 },
>> -         "data": { "speed": 0, "offset": 0, "len": 67108864,
>> -                   "error": "No space left on device",
>> -                   "device": "drive1", "type": "backup" },
>> -         "event": "BLOCK_JOB_COMPLETED" }
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "speed": 0,
>> +           "offset": 0,
>> +           "len": 67108864,
>> +           "error": "No space left on device",
>> +           "device": "drive0",
>> +           "type": "backup"
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>=20
> Should not BLOCK_JOB_ERROR go first?
>=20

I'll check. I didn't update the ordering here from what I wrote back then=
.

>>  =20
>> -4. Delete the failed incremental, and re-create the image.
>> +4. Delete the failed image, and re-create it.
>>  =20
>>      .. code:: bash
>>  =20
>> -       $ rm incremental.0.img
>> -       $ qemu-img create -f qcow2 incremental.0.img -b full_backup.im=
g -F qcow2
>> +       $ rm incremental.0.qcow
>=20
> s/qcow/qcow2
>=20

Ah dang. I even looked for this typo specifically because I made it so
often.

>> +       $ qemu-img create -f qcow2 incremental.0.qcow2 \
>> +         -b full_backup.qcow2 -F qcow2
>>  =20
>>   5. Retry the command after fixing the underlying problem, such as
>>      freeing up space on the backup volume:
>>  =20
>>      .. code:: json
>>  =20
>> -       { "execute": "drive-backup",
>> +    -> {
>> +         "execute": "drive-backup",
>>            "arguments": {
>>              "device": "drive0",
>>              "bitmap": "bitmap0",
>> -           "target": "incremental.0.img",
>> +           "target": "incremental.0.qcow2",
>>              "format": "qcow2",
>>              "sync": "incremental",
>>              "mode": "existing"
>>            }
>>          }
>>  =20
>> +    <- { "return": {} }
>> +
>>   6. Receive confirmation that the job completed successfully:
>>  =20
>>      .. code:: json
>>  =20
>> -       { "timestamp": { "seconds": 1424709668, "microseconds": 526525=
 },
>> -         "data": { "device": "drive1", "type": "backup",
>> -                   "speed": 0, "len": 67108864, "offset": 67108864},
>> -         "event": "BLOCK_JOB_COMPLETED" }
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive0",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 67108864,
>> +           "offset": 67108864
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>>  =20
>> -Partial Transactional Failures
>> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +Example: Partial Transactional Failures
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  =20
>> --  Sometimes, a transaction will succeed in launching and return
>> -   success, but then later the backup jobs themselves may fail. It is
>> -   possible that a management application may have to deal with a
>> -   partial backup failure after a successful transaction.
>> +QMP commands like `query-block <qemu-qmp-ref.html#index-query_002dblo=
ck>`_
>=20
> query-block ?
>=20

Ah, what the heck did I do here? I think this was a search-and-replace
gone awry somehow. Sorry.

>> +conceptually only start a job, and so these transactions may succeed =
even if
>> +the job later fails. This might have surprising interactions with not=
ions of
>> +how a "transaction" ought to behave.
>>  =20
>> --  If multiple backup jobs are specified in a single transaction, whe=
n
>> -   one of them fails, it will not interact with the other backup jobs=
 in
>> -   any way.
>> +This distinction means that on occasion, a transaction containing suc=
h job
>> +launching commands may appear to succeed and return success, but late=
r
>> +individual jobs associated with the transaction may fail. It is possi=
ble that a
>> +management application may have to deal with a partial backup failure=
 after a
>> +"successful" transaction.
>>  =20
>> --  The job(s) that succeeded will clear the dirty bitmap associated w=
ith
>> -   the operation, but the job(s) that failed will not. It is not "saf=
e"
>> -   to delete any incremental backups that were created successfully i=
n
>> -   this scenario, even though others failed.
>> +If multiple backup jobs are specified in a single transaction, if one=
 of those
>> +jobs fails, it will not interact with the other backup jobs in any wa=
y by
>> +default. The job(s) that succeeded will clear the dirty bitmap associ=
ated with
>> +the operation, but the job(s) that failed will not. It is therefore n=
ot safe to
>> +delete any incremental backups that were created successfully in this=
 scenario,
>> +even though others failed.
>>  =20
>> -Example
>> -^^^^^^^
>> +This example illustrates a transaction with two backup jobs, where on=
e fails
>> +and one succeeds:
>>  =20
>> --  QMP example highlighting two backup jobs:
>> +#. Issue the transaction to start a backup of both drives. Note that =
the
>> +   transaction is accepted, indicating that the jobs are started succ=
esfully.
>>  =20
>>      .. code:: json
>>  =20
>> -       { "execute": "transaction",
>> +    -> {
>> +         "execute": "transaction",
>>            "arguments": {
>>              "actions": [
>> -             { "type": "drive-backup",
>> -               "data": { "device": "drive0", "bitmap": "bitmap0",
>> -                         "format": "qcow2", "mode": "existing",
>> -                         "sync": "incremental", "target": "d0-incr-1.=
qcow2" } },
>> -             { "type": "drive-backup",
>> -               "data": { "device": "drive1", "bitmap": "bitmap1",
>> -                         "format": "qcow2", "mode": "existing",
>> -                         "sync": "incremental", "target": "d1-incr-1.=
qcow2" } },
>> -           ]
>> +           {
>> +             "type": "drive-backup",
>> +             "data": {
>> +               "device": "drive0",
>> +               "bitmap": "bitmap0",
>> +               "format": "qcow2",
>> +               "mode": "existing",
>> +               "sync": "incremental",
>> +               "target": "drive0.inc0.qcow2"
>> +             }
>> +           },
>> +           {
>> +             "type": "drive-backup",
>> +             "data": {
>> +               "device": "drive1",
>> +               "bitmap": "bitmap0",
>> +               "format": "qcow2",
>> +               "mode": "existing",
>> +               "sync": "incremental",
>> +               "target": "drive1.inc0.qcow2"
>> +             }
>> +           }]
>>            }
>>          }
>>  =20
>> --  QMP example response, highlighting one success and one failure:
>> +    <- { "return": {} }
>>  =20
>> -   -  Acknowledgement that the Transaction was accepted and jobs were
>> -      launched:
>> +#. Receive notice that the first job has completed:
>>  =20
>> -      .. code:: json
>> +   .. code:: json
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive0",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 67108864,
>> +           "offset": 67108864
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>>  =20
>> -          { "return": {} }
>> +#. Receive notice that the second job has failed:
>>  =20
>> -   -  Later, QEMU sends notice that the first job was completed:
>> +   .. code:: json
>>  =20
>> -      .. code:: json
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive1",
>> +           "action": "report",
>> +           "operation": "read"
>> +         },
>> +         "event": "BLOCK_JOB_ERROR"
>> +       }
>>  =20
>> -          { "timestamp": { "seconds": 1447192343, "microseconds": 615=
698 },
>> -            "data": { "device": "drive0", "type": "backup",
>> -                       "speed": 0, "len": 67108864, "offset": 6710886=
4 },
>> -            "event": "BLOCK_JOB_COMPLETED"
>> -          }
>> +    ...
>>  =20
>> -   -  Later yet, QEMU sends notice that the second job has failed:
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "speed": 0,
>> +           "offset": 0,
>> +           "len": 67108864,
>> +           "error": "Input/output error",
>> +           "device": "drive1",
>> +           "type": "backup"
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>>  =20
>> -      .. code:: json
>> +At the conclusion of the above example, ``drive0.inc0.qcow2`` is vali=
d and must
>> +be kept, but ``drive1.inc0.qcow2`` is incomplete and should be delete=
d. If a
>> +VM-wide incremental backup of all drives at a point-in-time is to be =
made, new
>> +backups for both drives will need to be made, taking into account tha=
t a new
>> +incremental backup for drive0 needs to be based on top of ``drive0.in=
c0.qcow2``.
>>  =20
>> -          { "timestamp": { "seconds": 1447192399, "microseconds": 683=
015 },
>> -            "data": { "device": "drive1", "action": "report",
>> -                      "operation": "read" },
>> -            "event": "BLOCK_JOB_ERROR" }
>> +In other words, at the conclusion of the above example, we'd have mad=
e only an
>> +incremental backup for drive0 but not drive1. The last VM-wide crash
>> +consistent backup we have access to in this case is the anchor point.
>>  =20
>> -      .. code:: json
>> +.. code:: text
>>  =20
>> -          { "timestamp": { "seconds": 1447192399, "microseconds":
>> -          685853 }, "data": { "speed": 0, "offset": 0, "len": 6710886=
4,
>> -          "error": "Input/output error", "device": "drive1", "type":
>> -          "backup" }, "event": "BLOCK_JOB_COMPLETED" }
>> +          [drive0.full.qcow2] <-- [drive0.inc0.qcow2]
>> +          [drive1.full.qcow2]
>>  =20
>> --  In the above example, ``d0-incr-1.qcow2`` is valid and must be kep=
t,
>> -   but ``d1-incr-1.qcow2`` is invalid and should be deleted. If a VM-=
wide
>> -   incremental backup of all drives at a point-in-time is to be made,
>> -   new backups for both drives will need to be made, taking into acco=
unt
>> -   that a new incremental backup for drive0 needs to be based on top =
of
>> -   ``d0-incr-1.qcow2``.
>> +To repair this, issue a new incremental backup across both drives. Th=
e result
>> +will be backup chains that resemble the following:
>>  =20
>> -Grouped Completion Mode
>> -~~~~~~~~~~~~~~~~~~~~~~~
>> +.. code:: text
>>  =20
>> --  While jobs launched by transactions normally complete or fail on
>> -   their own, it is possible to instruct them to complete or fail
>> -   together as a group.
>> +          [drive0.full.qcow2] <-- [drive0.inc0.qcow2] <-- [drive0.inc=
1.qcow2]
>> +          [drive1.full.qcow2] <-------------------------- [drive1.inc=
1.qcow2]
>>  =20
>> --  QMP transactions take an optional properties structure that can
>> -   affect the semantics of the transaction.
>> +Example: Grouped Completion Mode
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  =20
>> --  The "completion-mode" transaction property can be either "individu=
al"
>> -   which is the default, legacy behavior described above, or "grouped=
,"
>> -   a new behavior detailed below.
>> +While jobs launched by transactions normally complete or fail individ=
ually,
>> +it's possible to instruct them to complete or fail together as a grou=
p. QMP
>> +transactions take an optional properties structure that can affect th=
e
>> +behavior of the transaction.
>>  =20
>> --  Delayed Completion: In grouped completion mode, no jobs will repor=
t
>> -   success until all jobs are ready to report success.
>> +The ``completion-mode`` transaction property can be either ``individu=
al`` which
>> +is the default legacy behavior described above, or ``grouped``, detai=
led below.
>>  =20
>> --  Grouped failure: If any job fails in grouped completion mode, all
>> -   remaining jobs will be cancelled. Any incremental backups will
>> -   restore their dirty bitmap objects as if no backup command was eve=
r
>> -   issued.
>> +In ``grouped`` completion mode, no jobs will report success until all=
 jobs are
>> +ready to report success. If any job fails, all other jobs will be can=
celed.
>>  =20
>> -   -  Regardless of if QEMU reports a particular incremental backup j=
ob
>> -      as CANCELLED or as an ERROR, the in-memory bitmap will be
>> -      restored.
>> +Regardless of if a participating incremental backup job failed or was=
 canceled,
>> +their associated bitmaps will all be rolled back as in individual fai=
lure
>> +cases.
>>  =20
>> -Example
>> -^^^^^^^
>> +Here's the same multi-drive backup scenario from `Example: Partial
>> +Transactional Failures`_, but with the ``grouped`` completion-mode pr=
operty
>> +applied:
>>  =20
>> --  Here's the same example scenario from above with the new property:
>> +#. Issue the multi-drive incremental backup transaction:
>>  =20
>>      .. code:: json
>>  =20
>> -       { "execute": "transaction",
>> +    -> {
>> +         "execute": "transaction",
>>            "arguments": {
>> -           "actions": [
>> -             { "type": "drive-backup",
>> -               "data": { "device": "drive0", "bitmap": "bitmap0",
>> -                         "format": "qcow2", "mode": "existing",
>> -                         "sync": "incremental", "target": "d0-incr-1.=
qcow2" } },
>> -             { "type": "drive-backup",
>> -               "data": { "device": "drive1", "bitmap": "bitmap1",
>> -                         "format": "qcow2", "mode": "existing",
>> -                         "sync": "incremental", "target": "d1-incr-1.=
qcow2" } },
>> -           ],
>>              "properties": {
>>                "completion-mode": "grouped"
>> -           }
>> +           },
>> +           "actions": [
>> +           {
>> +             "type": "drive-backup",
>> +             "data": {
>> +               "device": "drive0",
>> +               "bitmap": "bitmap0",
>> +               "format": "qcow2",
>> +               "mode": "existing",
>> +               "sync": "incremental",
>> +               "target": "drive0.inc0.qcow2"
>> +             }
>> +           },
>> +           {
>> +             "type": "drive-backup",
>> +             "data": {
>> +               "device": "drive1",
>> +               "bitmap": "bitmap0",
>> +               "format": "qcow2",
>> +               "mode": "existing",
>> +               "sync": "incremental",
>> +               "target": "drive1.inc0.qcow2"
>> +             }
>> +           }]
>>            }
>>          }
>>  =20
>> --  QMP example response, highlighting a failure for ``drive2``:
>> -
>> -   -  Acknowledgement that the Transaction was accepted and jobs were
>> -      launched:
>> -
>> -      .. code:: json
>> -
>> -          { "return": {} }
>> -
>> -   -  Later, QEMU sends notice that the second job has errored out, b=
ut
>> -      that the first job was also cancelled:
>> -
>> -      .. code:: json
>> -
>> -          { "timestamp": { "seconds": 1447193702, "microseconds": 632=
377 },
>> -            "data": { "device": "drive1", "action": "report",
>> -                      "operation": "read" },
>> -            "event": "BLOCK_JOB_ERROR" }
>> -
>> -      .. code:: json
>> -
>> -          { "timestamp": { "seconds": 1447193702, "microseconds": 640=
074 },
>> -            "data": { "speed": 0, "offset": 0, "len": 67108864,
>> -                      "error": "Input/output error",
>> -                      "device": "drive1", "type": "backup" },
>> -            "event": "BLOCK_JOB_COMPLETED" }
>> -
>> -      .. code:: json
>> -
>> -          { "timestamp": { "seconds": 1447193702, "microseconds": 640=
163 },
>> -            "data": { "device": "drive0", "type": "backup", "speed": =
0,
>> -                      "len": 67108864, "offset": 16777216 },
>> -            "event": "BLOCK_JOB_CANCELLED" }
>> +#. Receive acknowledgement that the Transaction was accepted, and job=
s were
>> +   launched:
>> +
>> +    <- { "return": {} }
>=20
> in previous example, you instead add a note:
>    Note that the
>    transaction is accepted, indicating that the jobs are started succes=
fully.
>=20

Will make consistent. Thank you for this attention to detail.

>> +
>> +#. Receive notification that the backup job for ``drive1`` has failed=
:
>> +
>> +   .. code:: json
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive1",
>> +           "action": "report",
>> +           "operation": "read"
>> +         },
>> +         "event": "BLOCK_JOB_ERROR"
>> +       }
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "speed": 0,
>> +           "offset": 0,
>> +           "len": 67108864,
>> +           "error": "Input/output error",
>> +           "device": "drive1",
>> +           "type": "backup"
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
>> +
>> +#. Receive notification that the job for ``drive0`` has been canceled=
:
>> +
>> +   .. code:: json
>> +
>> +    <- {
>> +         "timestamp": {...}
>> +         "data": {
>> +           "device": "drive0",
>> +           "type": "backup",
>> +           "speed": 0,
>> +           "len": 67108864,
>> +           "offset": 16777216
>> +         },
>> +         "event": "BLOCK_JOB_CANCELLED"
>> +       }
>>  =20
>=20
> Good to add here some conclusion for example, like removing failed targ=
et images
> and note the the transaction operation may be safely retried.
>=20

Agree.

>=20
>>   .. raw:: html
>>  =20
>>      <!--
>>      The FreeBSD Documentation License
>>  =20
>> -   Redistribution and use in source (Markdown) and 'compiled' forms (=
SGML, HTML,
>> -   PDF, PostScript, RTF and so forth) with or without modification, a=
re permitted
>> -   provided that the following conditions are met:
>> +   Redistribution and use in source (ReST) and 'compiled' forms (SGML=
, HTML,
>> +   PDF, PostScript, RTF and so forth) with or without modification, a=
re
>> +   permitted provided that the following conditions are met:
>>  =20
>> -   Redistributions of source code (Markdown) must retain the above co=
pyright
>> -   notice, this list of conditions and the following disclaimer of th=
is file
>> -   unmodified.
>> +   Redistributions of source code (ReST) must retain the above copyri=
ght notice,
>> +   this list of conditions and the following disclaimer of this file =
unmodified.
>>  =20
>> -   Redistributions in compiled form (transformed to other DTDs, conve=
rted to PDF,
>> -   PostScript, RTF and other formats) must reproduce the above copyri=
ght notice,
>> -   this list of conditions and the following disclaimer in the docume=
ntation and/or
>> -   other materials provided with the distribution.
>> +   Redistributions in compiled form (transformed to other DTDs, conve=
rted to
>> +   PDF, PostScript, RTF and other formats) must reproduce the above c=
opyright
>> +   notice, this list of conditions and the following disclaimer in th=
e
>> +   documentation and/or other materials provided with the distributio=
n.
>>  =20
>> -   THIS DOCUMENTATION IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRI=
BUTORS "AS IS"
>> -   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED =
TO, THE
>> -   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR=
  PURPOSE ARE
>> -   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS=
  BE LIABLE
>> -   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSE=
QUENTIAL
>> -   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE =
GOODS OR
>> -   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)=
 HOWEVER
>> -   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT=
 LIABILITY,
>> -   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT=
 OF THE USE OF
>> -   THIS DOCUMENTATION, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAM=
AGE.
>> +   THIS DOCUMENTATION IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRI=
BUTORS "AS
>> +   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMI=
TED TO, THE
>> +   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR=
 PURPOSE
>> +   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBU=
TORS BE
>> +   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, O=
R
>> +   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT =
OF
>> +   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BU=
SINESS
>> +   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETH=
ER IN
>> +   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHER=
WISE)
>> +   ARISING IN ANY WAY OUT OF THE USE OF THIS DOCUMENTATION, EVEN IF A=
DVISED OF
>> +   THE POSSIBILITY OF SUCH DAMAGE.
>>      -->
>> diff --git a/Makefile b/Makefile
>> index 04a0d45050..ff9ce2ed4c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -899,7 +899,7 @@ docs/version.texi: $(SRC_PATH)/VERSION
>>   sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/i=
nterop/index.html
>>  =20
>>   # Canned command to build a single manual
>> -build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -b =
html -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctrees/=
$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR=
)/$1")
>> +build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -n =
-b html -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctre=
es/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILD=
DIR)/$1")
>=20
> what is '-n'?
>=20

It complains about missing anchor references. I left it in by accident,
but I think we ought to check it in separately.

>>   # We assume all RST files in the manual's directory are used in it
>>   manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/do=
cs/$1/conf.py $(SRC_PATH)/docs/conf.py
>>  =20
>>
>=20
>=20

Thank you for the review! I will address what I can before adding new
sections for differential and push backups. I'd like to check this in to
revise our existing docs before moving on to add new stuff.

--js

