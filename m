Received: from eggs.gnu.org ([2001:4830:134:3::10]:42252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD4CR-0005lP-Ek
	for qemu-devel@nongnu.org; Tue, 23 May 2017 03:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD4CM-0006oE-Rn
	for qemu-devel@nongnu.org; Tue, 23 May 2017 03:25:47 -0400
References: <149546869825.1005.10210133978512879518@c05f1edc8ed1>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <48dfeca5-0640-796f-66ce-8cab198fcaef@redhat.com>
Date: Tue, 23 May 2017 09:25:30 +0200
MIME-Version: 1.0
In-Reply-To: <149546869825.1005.10210133978512879518@c05f1edc8ed1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] tests/libqtest: Print error instead of
 aborting when env variable is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-trivial@nongnu.org, armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 22.05.2017 17:58, no-reply@patchew.org wrote:
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
[...]
> 	 LEX convert-dtsv0-lexer.lex.c
> 	 DEP /tmp/qemu-test/src/dtc/fdtdump.c
> make[1]: flex: Command not found
> 	 BISON dtc-parser.tab.c
> make[1]: bison: Command not found
> 	 DEP /tmp/qemu-test/src/dtc/srcpos.c
> 	 LEX dtc-lexer.lex.c
> make[1]: flex: Command not found
> 	 DEP /tmp/qemu-test/src/dtc/treesource.c
> 	 DEP /tmp/qemu-test/src/dtc/livetree.c
> 	 DEP /tmp/qemu-test/src/dtc/fstree.c
> 	 DEP /tmp/qemu-test/src/dtc/flattree.c
> 	 DEP /tmp/qemu-test/src/dtc/dtc.c
> 	 DEP /tmp/qemu-test/src/dtc/data.c
> 	 DEP /tmp/qemu-test/src/dtc/checks.c
> 	CHK version_gen.h
> 	 BISON dtc-parser.tab.c
> make[1]: bison: Command not found
> 	 LEX convert-dtsv0-lexer.lex.c
> 	UPD version_gen.h
> make[1]: flex: Command not found
> 	 LEX dtc-lexer.lex.c
> make[1]: flex: Command not found
> 	 DEP /tmp/qemu-test/src/dtc/util.c
> 	 LEX convert-dtsv0-lexer.lex.c
> 	 BISON dtc-parser.tab.c
> make[1]: flex: Command not found
> make[1]: bison: Command not found
> 	 LEX dtc-lexer.lex.c
> make[1]: flex: Command not found

Looks like flex and bison are missing in the docker image? Could someone
please add it?

[...]
>   CC      replay/replay-internal.o
> /tmp/qemu-test/src/replay/replay-internal.c: In function =E2=80=98repla=
y_put_array=E2=80=99:
> /tmp/qemu-test/src/replay/replay-internal.c:65: warning: ignoring retur=
n value of =E2=80=98fwrite=E2=80=99, declared with attribute warn_unused_=
result

I guess that should be fixed?

[...]
>   CC      slirp/tcp_input.o
>   CC      slirp/tcp_output.o
>   CC      slirp/tcp_subr.o
>   CC      slirp/tcp_timer.o
> /tmp/qemu-test/src/slirp/tcp_input.c: In function =E2=80=98tcp_input=E2=
=80=99:
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
p=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
len=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
tos=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
id=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
off=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
ttl=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
sum=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
src.s_addr=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:219: warning: =E2=80=98save_ip.ip_=
dst.s_addr=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/slirp/tcp_input.c:220: warning: =E2=80=98save_ip6.ip=
_nh=E2=80=99 may be used uninitialized in this function

I've never seen these warnings in tcp_input.c before ... and they also
look like false positives too me ... is that GCC in the docker image too
sensitive?

[...]
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
> /tmp/qemu-test/src/hw/i386/pc_piix.c: In function =E2=80=98igd_passthro=
ugh_isa_bridge_create=E2=80=99:
> /tmp/qemu-test/src/hw/i386/pc_piix.c:1067: warning: =E2=80=98pch_rev_id=
=E2=80=99 may be used uninitialized in this function

dito

>   CC      aarch64-softmmu/hw/usb/tusb6010.o
> /tmp/qemu-test/src/hw/i386/acpi-build.c: In function =E2=80=98build_app=
end_pci_bus_devices=E2=80=99:
> /tmp/qemu-test/src/hw/i386/acpi-build.c:525: warning: =E2=80=98notify_m=
ethod=E2=80=99 may be used uninitialized in this function

dito

[...]
> /tmp/qemu-test/src/tests/ide-test.c: In function =E2=80=98cdrom_pio_imp=
l=E2=80=99:
> /tmp/qemu-test/src/tests/ide-test.c:803: warning: ignoring return value=
 of =E2=80=98fwrite=E2=80=99, declared with attribute warn_unused_result
> /tmp/qemu-test/src/tests/ide-test.c: In function =E2=80=98test_cdrom_dm=
a=E2=80=99:
> /tmp/qemu-test/src/tests/ide-test.c:899: warning: ignoring return value=
 of =E2=80=98fwrite=E2=80=99, declared with attribute warn_unused_result

Needs a patch, I guess?

>   GTESTER tests/test-vmstate
> Failed to load simple/primitive:b_1
> Failed to load simple/primitive:i64_2
> Failed to load simple/primitive:i32_1
> Failed to load simple/primitive:i32_1
> Failed to load test/with_tmp:a
> Failed to load test/tmp_child_parent:f
> Failed to load test/tmp_child:parent
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp

That works for me when I run "make check" locally ... could my patch
have broken this, or is there something else wrong in the repository or
docker image?

[...]
>   GTESTER tests/test-qga
>   GTESTER tests/test-timed-average
>   GTESTER tests/test-io-task
>   GTESTER tests/test-io-channel-socket
>   GTESTER tests/test-io-channel-file
>   GTESTER tests/test-io-channel-command
>   GTESTER tests/test-io-channel-buffer
>   GTESTER tests/test-base64
>   GTESTER tests/test-crypto-ivgen
>   GTESTER tests/test-crypto-afsplit
>   GTESTER tests/test-crypto-xts
>   GTESTER tests/test-crypto-block
>   GTESTER tests/test-logging
>   GTESTER tests/test-replication
>   GTESTER tests/test-bufferiszero
>   GTESTER tests/test-uuid
>   GTESTER tests/ptimer-test
>   GTESTER tests/test-qapi-util
>   GTESTER check-qtest-x86_64
>   GTESTER check-qtest-aarch64
>   GTESTER tests/test-qobject-output-visitor
>   GTESTER tests/test-clone-visitor
>   GTESTER tests/test-qobject-input-visitor
>   GTESTER tests/test-qmp-commands
>   GTESTER tests/test-string-input-visitor
>   GTESTER tests/test-string-output-visitor
>   GTESTER tests/test-qmp-event
>   GTESTER tests/test-opts-visitor
>   GTESTER tests/test-qht-par
> qemu-system-aarch64: warning: CPU(s) not present in any NUMA nodes: CPU=
 2 [thread-id: 2], CPU 3 [thread-id: 3], CPU 6 [thread-id: 6], CPU 7 [thr=
ead-id: 7]
> qemu-system-aarch64: warning: All CPU(s) up to maxcpus should be descri=
bed in NUMA config, ability to start up with partial NUMA mappings is obs=
oleted and will be removed in future
> **
> ERROR:/tmp/qemu-test/src/tests/test-qga.c:894:test_qga_guest_exec: asse=
rtion failed: (exited)
> GTester: last random seed: R02S88fe048bce3aa693228ab12699fc6771
> make: *** [check-tests/test-qga] Error 1
> make: *** Waiting for unfinished jobs....

I also can not reproduce this here when running "make check". I also can
not see how this should be related to my patch ... could it be that the
docker image was simply running into some time out problems here 'cause
the server was overloaded? In that case we should maybe increase the
timeout value in test_qga_guest_exec() ?

 Thomas
