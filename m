Received: from eggs.gnu.org ([2001:4830:134:3::10]:39577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crIph-0006zn-4h
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 02:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crIpe-00063k-1W
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 02:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1crIpd-00062q-S9
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 02:36:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D83377E9CB
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 06:36:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-4-git-send-email-armbru@redhat.com>
	<011d21ee-aa96-2541-2e54-16c423f07cce@redhat.com>
	<878tnv6e6q.fsf@dusky.pond.sub.org>
	<385d2fa4-a7ec-e22c-e89d-5387cccc2ca4@redhat.com>
	<ff1ac3a6-2ad0-f3aa-f085-17e1fc43d21c@redhat.com>
Date: Fri, 24 Mar 2017 07:36:14 +0100
In-Reply-To: <ff1ac3a6-2ad0-f3aa-f085-17e1fc43d21c@redhat.com> (Eric Blake's
	message of "Thu, 23 Mar 2017 15:51:25 -0500")
Message-ID: <87shm3yye9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to
 extract list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 03/23/2017 02:18 PM, Eric Blake wrote:
>
>>>>> -            if (port) {
>>>>> -                /* check for ipv6 */
>>>>> -                if (strchr(host, ':')) {
>>>>> -                    strbuf = g_strdup_printf("[%s]:%s", host, port);
>>>>> -                } else {
>>>>> -                    strbuf = g_strdup_printf("%s:%s", host, port);
>>>>
>>>> The old code only prints port information if it is present...
>>>>
>
>>>> ...but the new code unconditionally prints port information, even when
>>>> port == NULL.  Oops.
>>>
>>> How can port be null?  SocketAddress member port is mandatory...
>> 
>> Indeed. Does that mean the old code had a dead branch? Looks like it!
>
> Or else my reading of the old code was wrong.  It looks like port was
> optional on the command line, but in the conversion to QemuOpts, a
> missing port was treated as the default port.  Now that you are not
> going through QemuOpts, you have to make sure that you can still supply
> a default port to keep the QAPI happy with a mandatory port.

Who is "you", and what exactly does "you" have to do?  ;)
