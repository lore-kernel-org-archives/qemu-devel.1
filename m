Received: from eggs.gnu.org ([2001:4830:134:3::10]:49653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMZg1-000735-Hv
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMZfy-0006NS-G6
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:28:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gMZfs-0006Li-Ul
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:28:18 -0500
References: <154210908486.5592.17919293017406536232@015909e0f939>
	<eac231f1-1607-ea61-49de-0b6df2ba1a45@redhat.com>
	<126e3a89-9c79-694d-c56c-c4db12b68f3a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <151f5fb1-98d4-5414-aad0-f6c7d704686a@redhat.com>
Date: Tue, 13 Nov 2018 15:28:01 +0100
MIME-Version: 1.0
In-Reply-To: <126e3a89-9c79-694d-c56c-c4db12b68f3a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-3.2 0/7] Get rid of global_qtest in
 some of the qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ben@skyportsystems.com, jsnow@redhat.com, pbonzini@redhat.com, imammedo@redhat.com

On 2018-11-13 14:36, Laurent Vivier wrote:
> On 13/11/2018 13:31, Thomas Huth wrote:
>> On 2018-11-13 12:38, no-reply@patchew.org wrote:
>>> Hi,
>>>
>>> This series failed docker-quick@centos7 build test. Please find the t=
esting commands and
>>> their output below. If you have Docker installed, you can probably re=
produce it
>>> locally.
>>>
>>> Type: series
>>> Message-id: 1542049690-12826-1-git-send-email-thuth@redhat.com
>>> Subject: [Qemu-devel] [PATCH v1 for-3.2 0/7] Get rid of global_qtest =
in some of the qtests
>>>
>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>>> #!/bin/bash
>>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D8
>> [...]
>>>   CC      tests/test-hmp.o
>>>   TEST    decodetree.py
>>>   LINK    tests/check-qdict
>>>   LINK    tests/check-block-qdict
>>>   LINK    tests/test-char
>>>   LINK    tests/check-qnum
>>>   LINK    tests/check-qstring
>>>   LINK    tests/check-qlist
>>>   LINK    tests/check-qnull
>>>   LINK    tests/check-qobject
>>>   LINK    tests/check-qjson
>>>   LINK    tests/check-qlit
>>>   LINK    tests/test-qobject-output-visitor
>>>   LINK    tests/test-clone-visitor
>>>   LINK    tests/test-qobject-input-visitor
>>>   LINK    tests/test-qmp-cmds
>>>   LINK    tests/test-string-input-visitor
>>>   LINK    tests/test-string-output-visitor
>>>   LINK    tests/test-qmp-event
>>>   LINK    tests/test-opts-visitor
>>>   LINK    tests/test-coroutine
>>>   LINK    tests/test-visitor-serialization
>>>   LINK    tests/test-iov
>>>   LINK    tests/test-aio
>>>   LINK    tests/test-aio-multithread
>>>   LINK    tests/test-throttle
>>>   LINK    tests/test-thread-pool
>>>   LINK    tests/test-hbitmap
>>>   LINK    tests/test-bdrv-drain
>>>   LINK    tests/test-blockjob
>>>   LINK    tests/test-blockjob-txn
>>>   LINK    tests/test-block-backend
>>>   LINK    tests/test-x86-cpuid
>>>   LINK    tests/test-xbzrle
>>>   LINK    tests/test-vmstate
>>>   LINK    tests/test-cutils
>>>   LINK    tests/test-shift128
>>>   LINK    tests/test-mul64
>>>   LINK    tests/test-int128
>>>   LINK    tests/rcutorture
>>>   LINK    tests/test-rcu-list
>>>   LINK    tests/test-rcu-simpleq
>>>   LINK    tests/test-rcu-tailq
>>>   LINK    tests/test-qdist
>>>   LINK    tests/test-qht
>>>   LINK    tests/qht-bench
>>>   LINK    tests/test-bitops
>>>   LINK    tests/test-bitcnt
>>>   LINK    tests/test-qdev-global-props
>>>   LINK    tests/check-qom-interface
>>>   LINK    tests/check-qom-proplist
>>>   LINK    tests/test-qemu-opts
>>>   LINK    tests/test-keyval
>>>   LINK    tests/test-write-threshold
>>>   LINK    tests/test-crypto-hash
>>>   LINK    tests/test-crypto-hmac
>>>   LINK    tests/test-crypto-cipher
>>>   LINK    tests/test-crypto-secret
>>>   LINK    tests/test-qga
>>>   LINK    tests/test-timed-average
>>>   LINK    tests/test-util-sockets
>>>   LINK    tests/test-io-task
>>>   LINK    tests/test-io-channel-socket
>>>   LINK    tests/test-io-channel-file
>>>   LINK    tests/test-io-channel-command
>>>   LINK    tests/test-io-channel-buffer
>>>   LINK    tests/test-base64
>>>   LINK    tests/test-crypto-pbkdf
>>>   LINK    tests/test-crypto-ivgen
>>>   LINK    tests/test-crypto-afsplit
>>>   LINK    tests/test-crypto-xts
>>>   LINK    tests/test-crypto-block
>>>   LINK    tests/test-logging
>>>   LINK    tests/test-replication
>>>   LINK    tests/test-bufferiszero
>>>   LINK    tests/test-uuid
>>>   LINK    tests/ptimer-test
>>>   LINK    tests/test-qapi-util
>>>   LINK    tests/vhost-user-test
>>>   LINK    tests/endianness-test
>>>   LINK    tests/fdc-test
>>>   LINK    tests/ide-test
>>>   LINK    tests/ahci-test
>>>   LINK    tests/hd-geo-test
>>>   LINK    tests/boot-order-test
>>>   LINK    tests/bios-tables-test
>>>   LINK    tests/boot-serial-test
>>>   LINK    tests/pxe-test
>>>   LINK    tests/rtc-test
>>>   LINK    tests/ipmi-kcs-test
>>>   LINK    tests/ipmi-bt-test
>>>   LINK    tests/i440fx-test
>>>   LINK    tests/fw_cfg-test
>>>   LINK    tests/drive_del-test
>>>   LINK    tests/wdt_ib700-test
>>>   LINK    tests/tco-test
>>>   LINK    tests/e1000-test
>>>   LINK    tests/e1000e-test
>>>   LINK    tests/rtl8139-test
>>>   LINK    tests/pcnet-test
>>>   LINK    tests/eepro100-test
>>>   LINK    tests/ne2000-test
>>>   LINK    tests/nvme-test
>>>   LINK    tests/ac97-test
>>>   LINK    tests/es1370-test
>>>   LINK    tests/virtio-net-test
>>>   LINK    tests/virtio-balloon-test
>>>   LINK    tests/virtio-blk-test
>>>   LINK    tests/virtio-rng-test
>>>   LINK    tests/virtio-scsi-test
>>>   LINK    tests/virtio-serial-test
>>>   LINK    tests/virtio-console-test
>>>   LINK    tests/tpci200-test
>>>   LINK    tests/ipoctal232-test
>>>   LINK    tests/display-vga-test
>>>   LINK    tests/intel-hda-test
>>>   LINK    tests/ivshmem-test
>>>   LINK    tests/megasas-test
>>>   LINK    tests/vmxnet3-test
>>>   LINK    tests/pvpanic-test
>>>   LINK    tests/i82801b11-test
>>>   LINK    tests/ioh3420-test
>>>   LINK    tests/usb-hcd-ohci-test
>>>   LINK    tests/usb-hcd-uhci-test
>>>   LINK    tests/usb-hcd-xhci-test
>>>   LINK    tests/cpu-plug-test
>>>   LINK    tests/q35-test
>>>   LINK    tests/vmgenid-test
>>>   LINK    tests/tpm-crb-swtpm-test
>>>   LINK    tests/tpm-crb-test
>>>   LINK    tests/tpm-tis-swtpm-test
>>>   LINK    tests/tpm-tis-test
>>>   LINK    tests/test-netfilter
>>>   LINK    tests/test-filter-mirror
>>>   LINK    tests/test-filter-redirector
>>>   LINK    tests/migration-test
>>>   LINK    tests/test-x86-cpuid-compat
>>>   LINK    tests/numa-test
>>>   LINK    tests/sdhci-test
>>>   LINK    tests/qmp-test
>>>   LINK    tests/qmp-cmd-test
>>>   LINK    tests/device-introspect-test
>>>   LINK    tests/cdrom-test
>>>   LINK    tests/machine-none-test
>>>   LINK    tests/qom-test
>>>   LINK    tests/test-hmp
>>>   GTESTER tests/check-qdict
>>>   GTESTER tests/check-block-qdict
>>>   GTESTER tests/test-char
>>>   GTESTER tests/check-qstring
>>>   GTESTER tests/check-qlist
>>>   GTESTER tests/check-qnum
>>>   GTESTER tests/check-qnull
>>>   GTESTER tests/check-qobject
>>>   GTESTER tests/check-qjson
>>>   GTESTER tests/check-qlit
>>>   GTESTER tests/test-qobject-output-visitor
>>>   GTESTER tests/test-clone-visitor
>>>   GTESTER tests/test-qobject-input-visitor
>>>   GTESTER tests/test-qmp-cmds
>>>   GTESTER tests/test-string-input-visitor
>>>   GTESTER tests/test-string-output-visitor
>>>   GTESTER tests/test-qmp-event
>>>   GTESTER tests/test-opts-visitor
>>>   GTESTER tests/test-coroutine
>>>   GTESTER tests/test-visitor-serialization
>>>   GTESTER tests/test-iov
>>>   GTESTER tests/test-aio
>>>   GTESTER tests/test-aio-multithread
>>>   GTESTER tests/test-throttle
>>>   GTESTER tests/test-thread-pool
>>>   GTESTER tests/test-hbitmap
>>>   GTESTER tests/test-bdrv-drain
>>>   GTESTER tests/test-blockjob
>>>   GTESTER tests/test-blockjob-txn
>>>   GTESTER tests/test-block-backend
>>>   GTESTER tests/test-x86-cpuid
>>>   GTESTER tests/test-xbzrle
>>>   GTESTER tests/test-vmstate
>>>   GTESTER tests/test-cutils
>>>   GTESTER tests/test-shift128
>>>   GTESTER tests/test-mul64
>>>   GTESTER tests/test-int128
>>>   GTESTER tests/test-rcu-list
>>>   GTESTER tests/rcutorture
>>>   GTESTER tests/test-rcu-simpleq
>>>   GTESTER tests/test-rcu-tailq
>>>   GTESTER tests/test-qdist
>>>   GTESTER tests/test-qht
>>>   LINK    tests/test-qht-par
>>>   GTESTER tests/test-bitops
>>>   GTESTER tests/test-bitcnt
>>>   GTESTER tests/test-qdev-global-props
>>>   GTESTER tests/check-qom-interface
>>>   GTESTER tests/check-qom-proplist
>>>   GTESTER tests/test-qemu-opts
>>>   GTESTER tests/test-keyval
>>>   GTESTER tests/test-write-threshold
>>>   GTESTER tests/test-crypto-hash
>>>   GTESTER tests/test-crypto-hmac
>>>   GTESTER tests/test-crypto-cipher
>>>   GTESTER tests/test-crypto-secret
>>>   GTESTER tests/test-qga
>>>   GTESTER tests/test-timed-average
>>>   GTESTER tests/test-util-sockets
>>>   GTESTER tests/test-io-task
>>>   GTESTER tests/test-io-channel-socket
>>>   GTESTER tests/test-io-channel-file
>>>   GTESTER tests/test-io-channel-command
>>>   GTESTER tests/test-io-channel-buffer
>>>   GTESTER tests/test-base64
>>>   GTESTER tests/test-crypto-pbkdf
>>>   GTESTER tests/test-crypto-ivgen
>>>   GTESTER tests/test-crypto-afsplit
>>>   GTESTER tests/test-crypto-xts
>>>   GTESTER tests/test-crypto-block
>>>   GTESTER tests/test-logging
>>>   GTESTER tests/test-replication
>>>   GTESTER tests/test-bufferiszero
>>>   GTESTER tests/test-uuid
>>>   GTESTER tests/ptimer-test
>>>   GTESTER tests/test-qapi-util
>>>   GTESTER check-qtest-x86_64
>>>   GTESTER check-qtest-aarch64
>>>   GTESTER tests/test-qht-par
>>> **
>>> ERROR:/tmp/qemu-test/src/tests/libqtest.c:324:socket_send: assertion =
failed (len > 0): (-1 > 0)
>>> GTester: last random seed: R02S3e15817a492d380c2a48648801cef237
>>> **
>>> ERROR:/tmp/qemu-test/src/tests/libqtest.c:324:socket_send: assertion =
failed (len > 0): (-1 > 0)
>>> GTester: last random seed: R02S24ce0fdbf119e4e9bb4e16b9c67fd2c2
>>> **
>>> ERROR:/tmp/qemu-test/src/tests/libqtest.c:324:socket_send: assertion =
failed (len > 0): (-1 > 0)
>>> GTester: last random seed: R02S25089dbdda9fa104190cdba37c441c02
>>> **
>>> ERROR:/tmp/qemu-test/src/tests/libqtest.c:324:socket_send: assertion =
failed (len > 0): (-1 > 0)
>>> GTester: last random seed: R02S416ede33c1c5179166207ca938b1294f
>>> **
>>> ERROR:/tmp/qemu-test/src/tests/libqtest.c:324:socket_send: assertion =
failed (len > 0): (-1 > 0)
>>> GTester: last random seed: R02S4bb85a3b303912703e9ab78e757513f7
>>
>> I don't get these errors when running "make check" locally ... is ther=
e
>> a way to determine which of the tests exactly failed here?
>=20
> This can happen if qemu-system crashes and the socket is closed while
> the test application is connected.

Found the problem with --enable-sanitizers - in the ide-test, the
"pcibus" does not get re-initialized between tests, since the variable
is never set back to NULL again:

    if (!pcibus) {
        pcibus =3D qpci_init_pc(global_qtest, NULL);
    }

It did not matter while the libqos code was always using global_qtest on
its own, but now that it uses the QTestState which is provided by the
parameter to qpci_init_pc, we've got to make sure to re-run
qpci_init_pc() each time global_qtest has changed. I'll cook a patch...

 Thomas
