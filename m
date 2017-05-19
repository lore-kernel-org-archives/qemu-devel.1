Received: from eggs.gnu.org ([2001:4830:134:3::10]:54320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBee8-0003gD-El
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBee7-0004yn-Mb
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:56:32 -0400
MIME-Version: 1.0
In-Reply-To: <20170518182039.GO4748@thinpad.lan.raisama.net>
References: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
	<1495094971-177754-4-git-send-email-imammedo@redhat.com>
	<20170518182039.GO4748@thinpad.lan.raisama.net>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 19 May 2017 10:56:29 +0100
Message-ID: <CAJSP0QUzOv0S8dPthgs-sYnoZ0fB8BDhPJ85+cvcSjpuXkGzWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] numa: silence incomplete mapping
 warning under qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Thu, May 18, 2017 at 7:20 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Thu, May 18, 2017 at 10:09:31AM +0200, Igor Mammedov wrote:
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>
> Where exactly is the test code that triggers those messages and
> requires this patch? I would like to document that in the commit
> message.

$ make V=1 check
TEST: tests/numa-test... (pid=30376)
  /x86_64/numa/mon/default:                                            OK
  /x86_64/numa/mon/cpus/explicit:                                      OK
  /x86_64/numa/mon/cpus/partial:
qemu-system-x86_64: warning: CPU(s) not present in any NUMA nodes: CPU
2 [socket-id: 2, core-id: 0, thread-id: 0], CPU 3 [socket-id: 3,
core-id: 0, thread-id: 0], CPU 6 [socket-id: 6, core-id: 0, thread-id:
0], CPU 7 [socket-id: 7, core-id: 0, thread-id: 0]
qemu-system-x86_64: warning: All CPU(s) up to maxcpus should be
described in NUMA config, ability to start up with partial NUMA
mappings is obsoleted and will be removed in future
OK
