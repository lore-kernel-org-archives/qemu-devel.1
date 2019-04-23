Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB2C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953FB20685
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953FB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIzmb-0004DL-GJ
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:04:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIzlI-0003aK-Un
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIzlG-0000Nm-P5
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hIzlC-0000F6-Cd; Tue, 23 Apr 2019 14:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B276D30A9CE0;
	Tue, 23 Apr 2019 18:03:07 +0000 (UTC)
Received: from [10.10.120.166] (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEE5016BE5;
	Tue, 23 Apr 2019 18:03:02 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190422221714.7630-1-jsnow@redhat.com>
	<20190422221714.7630-3-jsnow@redhat.com>
	<a8aa6da5-7951-e42b-23b2-3718dec543e9@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <70ec70ea-02e0-b740-2523-a2cc0d650d06@redhat.com>
Date: Tue, 23 Apr 2019 14:03:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a8aa6da5-7951-e42b-23b2-3718dec543e9@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 23 Apr 2019 18:03:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docs/interop/bitmaps: rewrite and
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
Cc: Fam Zheng <fam@euphon.net>, "aliang@redhat.com" <aliang@redhat.com>,
	"kchamart@redhat.com" <kchamart@redhat.com>,
	"qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"nsoffer@redhat.com" <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423180300.XLRn_W4hznU5PrniY3y8pbemO5jjetGw-e0PQGMlWUs@z>



On 4/23/19 1:58 PM, Vladimir Sementsov-Ogievskiy wrote:
> 23.04.2019 1:17, John Snow wrote:
>> This just about rewrites the entirety of the bitmaps.rst document to
>> make it consistent with the 4.0 release. I have added new features seen
>> in the 4.0 release, as well as tried to clarify some points that keep
>> coming up when discussing this feature both in-house and upstream.
>>
>> Yes, it's a lot longer, mostly due to examples. I get a bit chatty.
>> I could use a good editor to help reign in my chattiness.
>>
>> It does not yet cover pull backups or migration details, but I intend to
>> keep extending this document to cover those cases.
>>
>> Please try compiling it with sphinx and look at the rendered output, I
>> don't have hosting to share my copy at present. I think this new layout
>> reads nicer in the HTML format than the old one did, at the expense of
>> looking less readable in the source tree itself (though not completely
>> unmanagable. We did decide to convert it from Markdown to ReST, after
>> all, so I am going all-in on ReST.)
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
> 
> [..]
> 
>> +Bitmap Status
>> +-------------
>> +
>> +Dirty Bitmap objects can be queried with the QMP command `query-block
>> +<qemu-qmp-ref.html#index-query_002dblock>`_, and are visible via the
>> +`BlockDirtyInfo <qemu-qmp-ref.html#index-BlockDirtyInfo>`_ QAPI structure.
>> +
>> +This struct shows the name, granularity, and dirty byte count for each bitmap.
>> +Additionally, it shows several boolean status indicators:
>> +
>> +- ``recording``: This bitmap is recording writes.
>> +- ``busy``: This bitmap is in-use by an operation.
>> +- ``persistent``: This bitmap is a persistent type.
>> +- ``inconsistent``: This bitmap is corrupted and cannot be used.
>> +
>> +The ``+busy`` status prohibits you from deleting, clearing, or otherwise
>> +modifying a bitmap, and happens when the bitmap is being used for a backup
>> +operation or is in the process of being loaded from a migration. Many of the
>> +commands documented below will refuse to work on such bitmaps.
>> +
>> +The ``+inconsistent`` status similarly prohibits almost all operations,
>> +notably allowing only the ``block-dirty-bitmap-remove`` operation.
>> +
>> +There is also a deprecated "`DirtyBitmapStatus
>> +<qemu-qmp-ref.html#index-DirtyBitmapStatus>`_" field. a bitmap historically
> 
> I think, better s/DirtyBitmapStatus/status/, to use field name, not type for what
> to call "field".
> 
> 
>> +had five visible states:
>> +
>> +   #. ``Frozen``: This bitmap is currently in-use by an operation and is
>> +      immutable. It can't be deleted, renamed, reset, etc.
>> +
>> +      (This is now ``+busy``.)
>> +
>> +   #. ``Disabled``: This bitmap is not recording new writes.
>> +
> 
> [..]
> 
>> +Example: Incremental Push Backups without Backing Files
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Backup images are best kept off-site, so we often will not have the preceding
>> +backups in a chain available to link against. This is not a problem at backup
>> +time; we simply do not set the backing image when creating the destination
>> +image:
>> +
>> +#. Create a new destination image with no backing file set. We will need to
>> +   specify the size of the base image this time, because it isn't available
>> +   for QEMU to use to guess:
> 
> hmm, s/to use to guess/to guess/ ?
> 

Good point.

>>   
>>      .. code:: bash
>>   
> 
> [..]
> 
>> +Example: Individual Failures
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Backup jobs that fail individually behave simply as described above. This
>> +example shows the simplest case:
> 
> Hmm, I think the simplest would be full backup without mode=existing :),
> so suggest just s/This example.../Consider example below:/, or s/Backup/Incremental backup/
> 
>> +
>> +#. Create a target image:
>> +
>> +   .. code:: bash
>> +
>> +       $ qemu-img create -f qcow2 drive0.inc0.qcow2 \
>> +         -b drive0.full.qcow2 -F qcow2
>> +
>> +#. Attempt to create an incremental backup via QMP:
>> +
>> +   .. code:: json
>> +
>> +    -> {
>> +         "execute": "drive-backup",
>> +         "arguments": {
>> +           "device": "drive0",
>> +           "bitmap": "bitmap0",
>> +           "target": "drive0.inc0.qcow2",
>> +           "format": "qcow2",
>> +           "sync": "incremental",
>> +           "mode": "existing"
>> +         }
>> +       }
>> +
>> +    <- { "return": {} }
>> +
>> +#. Receive a pair of events indicating failure:
>> +
>> +   .. code:: json
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive0",
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
>> +           "error": "No space left on device",
>> +           "device": "drive0",
>> +           "type": "backup"
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
> 
> a bit strange to get ENOSPC on read (understand that you use blkdebug),
> consider s/read/write/ just for beauty
> 

You are absolutely right, this doesn't make sense in the context of
something you'd see in the wild.

>>   
>> -4. Delete the failed incremental, and re-create the image.
>> +#. Delete the failed image, and re-create it.
>>   
>>      .. code:: bash
> 
> [..]
> 
>> +
>> +Example: Partial Transactional Failures
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +QMP commands like `drive-backup <qemu-qmp-ref.html#index-drive_002dbackup>`_
>> +conceptually only start a job, and so transactions containing these commands
>> +may succeed even if the job it created later fails. This might have surprising
>> +interactions with notions of how a "transaction" ought to behave.
>> +
>> +This distinction means that on occasion, a transaction containing such job
>> +launching commands may appear to succeed and return success, but later
>> +individual jobs associated with the transaction may fail. It is possible that
>> +a management application may have to deal with a partial backup failure after
>> +a "successful" transaction.
>> +
>> +If multiple backup jobs are specified in a single transaction, if one of those
>> +jobs fails, it will not interact with the other backup jobs in any way by
>> +default. The job(s) that succeeded will clear the dirty bitmap associated with
>> +the operation, but the job(s) that failed will not. It is therefore not safe
>> +to delete any incremental backups that were created successfully in this
>> +scenario, even though others failed.
>> +
>> +This example illustrates a transaction with two backup jobs, where one fails
>> +and one succeeds:
>> +
>> +#. Issue the transaction to start a backup of both drives. Note that the
>> +   transaction is accepted, indicating that the jobs are started succesfully.
> 
> And now this "note" looks strange, as it related not to this list item but to the next.
> Actually, we can't "note" that in context of this list item.
> 
>>   
>>      .. code:: json
>>   
>> -       { "execute": "transaction",
>> +    -> {
>> +         "execute": "transaction",
>>            "arguments": {
>>              "actions": [
>> -             { "type": "drive-backup",
>> -               "data": { "device": "drive0", "bitmap": "bitmap0",
>> -                         "format": "qcow2", "mode": "existing",
>> -                         "sync": "incremental", "target": "d0-incr-1.qcow2" } },
>> -             { "type": "drive-backup",
>> -               "data": { "device": "drive1", "bitmap": "bitmap1",
>> -                         "format": "qcow2", "mode": "existing",
>> -                         "sync": "incremental", "target": "d1-incr-1.qcow2" } },
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
>>   
>> --  QMP example response, highlighting one success and one failure:
>> +#. Receive notice that the Transaction was accepted, and jobs were
>> +   launched:
>>   
>> -   -  Acknowledgement that the Transaction was accepted and jobs were
>> -      launched:
>> +   .. code:: json
>> +
>> +    <- { "return": {} }
>> +
>> +#. Receive notice that the first job has completed:
>>   
> 
> [..]
> 
>> -      .. code:: json
>> +At the conclusion of the above example, ``drive0.inc0.qcow2`` is valid and
>> +must be kept, but ``drive1.inc0.qcow2`` is incomplete and should be
>> +deleted. If a VM-wide incremental backup of all drives at a point-in-time is
>> +to be made, new backups for both drives will need to be made, taking into
>> +account that a new incremental backup for drive0 needs to be based on top of
>> +``drive0.inc0.qcow2``.
>>   
>> -          { "timestamp": { "seconds": 1447192399, "microseconds": 683015 },
>> -            "data": { "device": "drive1", "action": "report",
>> -                      "operation": "read" },
>> -            "event": "BLOCK_JOB_ERROR" }
>> +In other words, at the conclusion of the above example, we'd have made only an
>> +incremental backup for drive0 but not drive1. The last VM-wide crash
>> +consistent backup we have access to in this case is the anchor point.
> 
> Not sure about "anchor point", can't be it applied to incremental backup point?
> May be just "full-backup point" or something like this?
> 

You're right, I don't really use this term too consistently. I always
refer to them as "anchors" because they're at "the bottom of the chain"
but I should at least explain this terminology if I am going to use it.

>>   
>> -      .. code:: json
>> +.. code:: text
>>   
>> -          { "timestamp": { "seconds": 1447192399, "microseconds":
>> -          685853 }, "data": { "speed": 0, "offset": 0, "len": 67108864,
>> -          "error": "Input/output error", "device": "drive1", "type":
>> -          "backup" }, "event": "BLOCK_JOB_COMPLETED" }
>> +          [drive0.full.qcow2] <-- [drive0.inc0.qcow2]
>> +          [drive1.full.qcow2]
>>   
>> --  In the above example, ``d0-incr-1.qcow2`` is valid and must be kept,
>> -   but ``d1-incr-1.qcow2`` is invalid and should be deleted. If a VM-wide
>> -   incremental backup of all drives at a point-in-time is to be made,
>> -   new backups for both drives will need to be made, taking into account
>> -   that a new incremental backup for drive0 needs to be based on top of
>> -   ``d0-incr-1.qcow2``.
>> +To repair this, issue a new incremental backup across both drives. The result
>> +will be backup chains that resemble the following:
>>   
> 
> [..]
> 
> With or without my nit-picking suggestions:
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

They're good suggestions, so I will revise them. Thank you for reviewing
such a large document!

