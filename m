Received: from eggs.gnu.org ([2001:4830:134:3::10]:44840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBwX9-0002z6-AO
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBwX8-0003bN-Jf
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:07:03 -0400
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com>
	<877eou2nek.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <099d2af4-8fe3-f80c-693f-495accb26a17@redhat.com>
Date: Fri, 27 Apr 2018 08:06:48 +0200
MIME-Version: 1.0
In-Reply-To: <877eou2nek.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qom-test (was: [RFC PATCH] tests/device-introspect:
 Test devices with all machines, not only with "none")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 26.04.2018 13:54, Markus Armbruster wrote:
[...]
> Actually, a worse offender in the "waste everybody's time via redunancy"
> department could be qom-test.

Shall we change qom-test to also only test with the "none" machine in
the normal "make check" mode and only do the full test with all machines
in "make check SPEED=slow" ?

 Thomas
