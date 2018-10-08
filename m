Received: from eggs.gnu.org ([2001:4830:134:3::10]:58038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9a2e-0005br-E5
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9a2a-0001h6-HK
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:14:04 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <204d1911-765b-bd4b-27b8-3f1a35a6b9d6@redhat.com>
References: <cover.1537367701.git.berto@igalia.com>
	<ba0e2f728d7b2a0bbf5c0f44d907a4c7e3723501.1537367701.git.berto@igalia.com>
	<204d1911-765b-bd4b-27b8-3f1a35a6b9d6@redhat.com>
Date: Mon, 08 Oct 2018 20:13:58 +0200
Message-ID: <w517eis71cp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/14] block: Stop passing flags to
 bdrv_reopen_queue_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon 08 Oct 2018 04:48:50 AM CEST, Max Reitz wrote:

>> +    /* Old values are used for options that aren't set yet */
>> +    old_options = qdict_clone_shallow(bs->options);
>> +    bdrv_join_options(bs, options, old_options);
>> +    qobject_unref(old_options);
>> +
>> +    /* We have the final set of options so let's update the flags */
>> +    {
>> +        Error *local_err = NULL;
>> +        QemuOpts *opts;
>> +        QDict *options_copy = qdict_clone_shallow(options);
>
> I-I'm not sure this conforms to our coding style.
>
> While I applaud your effort to keep the patch size small, I know for
> sure I don't want to read code like this.  (Unless it's necessary
> because of some variables' lifetimes.)

I actually think it makes the code more readable if there are variables
with a very limited scope (like in this case). But I can also rewrite it
using a more traditional style.

Berto
