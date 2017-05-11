Received: from eggs.gnu.org ([2001:4830:134:3::10]:51232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8sj9-00013v-UC
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8sj4-0004cp-Tu
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:22:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8sj4-0004cg-O5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:22:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8540262673
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 18:22:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1494505358-15287-1-git-send-email-peterx@redhat.com>
	<1494505358-15287-5-git-send-email-peterx@redhat.com>
	<d938d532-6d11-0ec5-a24a-0a44519bc021@redhat.com>
Date: Thu, 11 May 2017 20:22:03 +0200
In-Reply-To: <d938d532-6d11-0ec5-a24a-0a44519bc021@redhat.com> (Eric Blake's
	message of "Thu, 11 May 2017 10:03:20 -0500")
Message-ID: <87lgq3ntis.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 4/4] utils: remove assert in
 size_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 05/11/2017 07:22 AM, Peter Xu wrote:
>> It's not very safe to assert in size_to_str(). Let's be inclusive.
>> 
>> It naturally allows negative values. Now it won't even limit on the
>> size, as long as double would allow.
>> 
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  util/cutils.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> Since you just introduced this in 2/4, I'd rather see the two squashed
> together if we decide this is the interface we want to support.

PATCH 2 factors it out of print_type_size().  Doing just that and
improving only on top makes some sense.
