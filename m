Received: from eggs.gnu.org ([2001:4830:134:3::10]:34439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fj5sg-00054F-QI
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fj5sb-0002VH-VI
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:46:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fj5sb-0002Ut-PI
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:46:13 -0400
Reply-To: thuth@redhat.com
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-22-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55305ddb-0551-6296-c98a-c3af1228b2d5@redhat.com>
Date: Fri, 27 Jul 2018 18:46:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-22-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/23] libqtest: Remove
 qtest_qmp_discard_response() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org, eblake@redhat.com

On 07/27/2018 05:13 PM, Markus Armbruster wrote:
> qtest_qmp_discard_response(...) is shorthand for
> qobject_unref(qtest_qmp(...), except it's not actually shorter.

But the latter is IMHO harder to read.
And it might be shorter in the compiled binary (one function call vs. two).

> Moreover, the presence of these functions encourage sloppy testing.

Shouldn't we then rather fix the tests to check for valid responses
instead of replacing this function with harder-to-read code?

 Thomas
