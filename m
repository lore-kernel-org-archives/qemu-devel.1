Received: from eggs.gnu.org ([2001:4830:134:3::10]:39118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003Mp-8Y
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxO-0001E7-Ij
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxO-0001DF-BU
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
	<20180823164025.12553-7-armbru@redhat.com>
	<a635a1a4-e645-46d9-f028-4fab27fe9f9a@redhat.com>
Date: Fri, 24 Aug 2018 21:32:46 +0200
In-Reply-To: <a635a1a4-e645-46d9-f028-4fab27fe9f9a@redhat.com> (Eric Blake's
	message of "Thu, 23 Aug 2018 12:05:48 -0500")
Message-ID: <87va7z5zmp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 06/58] qmp-test: Cover syntax and
 lexical errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/23/2018 11:39 AM, Markus Armbruster wrote:
>> qmp-test neglects to cover QMP input that isn't valid JSON.  libqtest
>> doesn't let us such input.  Add qtest_qmp_send_raw() for this purpose,
>
> s/us/us send/

Fixed in my pull request.  Thanks!
