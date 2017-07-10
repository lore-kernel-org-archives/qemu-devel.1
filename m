Received: from eggs.gnu.org ([2001:4830:134:3::10]:51807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUXP3-0004DZ-F5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUXOy-0003LL-K1
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:03:01 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUXOy-00038a-DP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:02:56 -0400
Received: by mail-qt0-x242.google.com with SMTP id c20so12284335qte.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 05:02:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
	<84wp7layt8.wl-Peter.Chubb@data61.csiro.au>
	<CAKmqyKMBiWcauXq3RayRYrhgcL+D2y4522h8to7KsRuUw+a2Ew@mail.gmail.com>
	<87d1987m2t.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7cb7b756-7d28-0470-9e02-c8e2a24f79c9@amsat.org>
Date: Mon, 10 Jul 2017 09:02:23 -0300
MIME-Version: 1.0
In-Reply-To: <87d1987m2t.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/6] Convert error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter.Chubb@data61.csiro.au, Peter Maydell <peter.maydell@linaro.org>, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, jcody@redhat.com, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Rob Herring <robh@kernel.org>, jdurgin@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>, philippe@mathieu-daude.net, pl@kamp.de, groug@kaod.org, Peter Chubb <peter.chubb@nicta.com.au>, ronniesahlberg@gmail.com, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, aneesh.kumar@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

Hi Alistair,

On 07/10/2017 05:06 AM, Markus Armbruster wrote:
> Alistair Francis <alistair.francis@xilinx.com> writes:
>> Yeah, I thought I saw this when I was doing it, but then everything
>> compiled so I figured it was fine.
>>
>> It must not all be included with the default ./configure, because I
>> just tried again and it all compiles for me.
> 
> The result of ./configure depends on the packages you got installed.
> You need quite a few development packages to get anywhere near a full
> compile.  For a first step, you could do worse than installing your
> distribution's QEMU package's build dependencies.

To avoid to install development packages on your host you can build 
using docker images which intend to cover the whole code base installing 
many dependencies.

For example (I don't have libiscsi installed on my workstation):

$ make docker-test-quick@debian-mipsel-cross
   BUILD   debian
   BUILD   debian-mipsel-cross
...
Configure options:
--enable-werror --target-list=x86_64-softmmu,aarch64-softmmu 
--prefix=/var/tmp/qemu-build/install --cross-prefix=mipsel-linux-gnu-
...
libiscsi support  yes
libnfs support    yes
build guest agent yes
...
   CC      nbd/server.o
   CC      nbd/client.o
   CC      nbd/common.o
   CC      block/iscsi.o
/tmp/qemu-test/src/block/iscsi.c: In function 'iscsi_open':
/tmp/qemu-test/src/block/iscsi.c:1764:21: error: character constant too 
long for its type [-Werror]
          warn_report('filename' option specified. "
                      ^
/tmp/qemu-test/src/block/iscsi.c:1764:32: error: expected ')' before 
'option'
          warn_report('filename' option specified. "
                                 ^
/tmp/qemu-test/src/block/iscsi.c:1764:50: error: missing terminating " 
character [-Werror]
          warn_report('filename' option specified. "
                                                   ^
/tmp/qemu-test/src/block/iscsi.c:1764:32: error: missing terminating " 
character
          warn_report('filename' option specified. "
                                 ^
/tmp/qemu-test/src/block/iscsi.c:1764:21: error: passing argument 1 of 
'warn_report' makes pointer from integer without a cast [-Werror]
          warn_report('filename' option specified. "
                      ^
In file included from /tmp/qemu-test/src/block/iscsi.c:33:0:
/tmp/qemu-test/src/include/qemu/error-report.h:44:6: note: expected 
'const char *' but argument is of type 'int'
  void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
       ^
/tmp/qemu-test/src/block/iscsi.c:1766:23: error: format not a string 
literal and no format arguments [-Werror=format-security]
                        "in the future");
                        ^
cc1: all warnings being treated as errors
/tmp/qemu-test/src/rules.mak:66: recipe for target 'block/iscsi.o' failed
make: *** [block/iscsi.o] Error 1
tests/docker/Makefile.include:122: recipe for target 'docker-run' failed
make[1]: *** [docker-run] Error 2
make: *** [docker-run-test-quick@debian-mipsel-cross] Error 2

Regards,

Phil.
