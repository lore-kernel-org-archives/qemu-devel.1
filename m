Received: from eggs.gnu.org ([2001:4830:134:3::10]:37063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydE0-0004Fb-Ir
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydDz-0003TO-Od
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:52:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eydDz-0003Ss-Jh
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:52:15 -0400
References: <20180321065506.21091-1-peterx@redhat.com>
	<20180321065506.21091-3-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f5af472-1606-ebe1-47c6-9b6bdc26cad9@redhat.com>
Date: Wed, 21 Mar 2018 07:52:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180321065506.21091-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] tests: add oob-test for qapi-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>

On 03/21/2018 01:55 AM, Peter Xu wrote:
> It simply tests the new OOB capability, and make sure the QAPISchema can
> parse it correctly.

We also want negative tests that cover any new error messages in the 
qapi generator (such as 'allow-oob':'bad' diagnosing a non-bool, or 
'allow-oob':false giving an error message that false is already the 
default such that only 'allow-oob':true makes sense).

Also, it's often easier to merge the positive test into the giant 
existing qapi-schema-test.json rather than creating a new positive test.

> +++ b/tests/qapi-schema/oob-test.out
> @@ -0,0 +1,6 @@
> +object q_empty
> +enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
> +    prefix QTYPE
> +module oob-test.json
> +command an-oob-command None -> None
> +   gen=True success_response=True boxed=False oob=True

At any rate, the positive test addition is good. I may beat you to 
submitting a v2 patch that covers the error messages that I'm thinking of.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
