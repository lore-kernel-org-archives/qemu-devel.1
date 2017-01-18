Received: from eggs.gnu.org ([2001:4830:134:3::10]:36310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTx6o-0000i2-Cz
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTx6j-0001wX-Dw
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:45:30 -0500
Date: Wed, 18 Jan 2017 22:45:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170118224442-mutt-send-email-mst@kernel.org>
References: <1484768294-23336-1-git-send-email-mst@redhat.com>
	<148476857571.214.7202332351357217430@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148476857571.214.7202332351357217430@790289a7ca88>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: fix up max size checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, qemu-stable@nongnu.org

On Wed, Jan 18, 2017 at 11:42:57AM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> Your series failed automatic build test.

Posted a wrong patch. Pls ignore, will repost.

> Please find the testing commands and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.



> Message-id: 1484768294-23336-1-git-send-email-mst@redhat.com
> Subject: [Qemu-devel] [PATCH] virtio: fix up max size checks
> Type: series
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=3D1
> export J=3D16
> make docker-test-quick@centos6
> make docker-test-mingw@fedora
> make docker-test-build@min-glib
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 41df2e9 virtio: fix up max size checks
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into 'dtc'...
> Submodule path 'dtc': checked out '65cc4d2748a2c2e6f27f1cf39e07a5dbabd8=
0ebf'
>   BUILD   centos6
> make[1]: Entering directory `/var/tmp/patchew-tester-tmp-gbyzu407/src'
>   ARCHIVE qemu.tgz
>   ARCHIVE dtc.tgz
>   COPY    RUNNER
>     RUN test-quick in qemu:centos6=20
> Packages installed:
> SDL-devel-1.2.14-7.el6_7.1.x86_64
> ccache-3.1.6-2.el6.x86_64
> epel-release-6-8.noarch
> gcc-4.4.7-17.el6.x86_64
> git-1.7.1-4.el6_7.1.x86_64
> glib2-devel-2.28.8-5.el6.x86_64
> libfdt-devel-1.4.0-1.el6.x86_64
> make-3.81-23.el6.x86_64
> package g++ is not installed
> pixman-devel-0.32.8-1.el6.x86_64
> tar-1.23-15.el6_8.x86_64
> zlib-devel-1.2.3-29.el6.x86_64
>=20
> Environment variables:
> PACKAGES=3Dlibfdt-devel ccache     tar git make gcc g++     zlib-devel =
glib2-devel SDL-devel pixman-devel     epel-release
> HOSTNAME=3D9d38526f1f38
> TERM=3Dxterm
> MAKEFLAGS=3D -j16
> HISTSIZE=3D1000
> J=3D16
> USER=3Droot
> CCACHE_DIR=3D/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=3D
> V=3D
> SHOW_ENV=3D1
> MAIL=3D/var/spool/mail/root
> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin=
:/usr/sbin:/usr/bin:/sbin:/bin
> PWD=3D/
> LANG=3Den_US.UTF-8
> TARGET_LIST=3D
> HISTCONTROL=3Dignoredups
> SHLVL=3D1
> HOME=3D/root
> TEST_DIR=3D/tmp/qemu-test
> LOGNAME=3Droot
> LESSOPEN=3D||/usr/bin/lesspipe.sh %s
> FEATURES=3D dtc
> DEBUG=3D
> G_BROKEN_FILENAMES=3D1
> CCACHE_HASHDIR=3D
> _=3D/usr/bin/env
>=20
> Configure options:
> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu --prefix=
=3D/var/tmp/qemu-build/install
> No C++ compiler available; disabling C++ specific optional code
> Install prefix    /var/tmp/qemu-build/install
> BIOS directory    /var/tmp/qemu-build/install/share/qemu
> binary directory  /var/tmp/qemu-build/install/bin
> library directory /var/tmp/qemu-build/install/lib
> module directory  /var/tmp/qemu-build/install/lib/qemu
> libexec directory /var/tmp/qemu-build/install/libexec
> include directory /var/tmp/qemu-build/install/include
> config directory  /var/tmp/qemu-build/install/etc
> local state directory   /var/tmp/qemu-build/install/var
> Manual directory  /var/tmp/qemu-build/install/share/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /tmp/qemu-test/src
> C compiler        cc
> Host C compiler   cc
> C++ compiler     =20
> Objective-C compiler cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g=20
> QEMU_CFLAGS       -I/usr/include/pixman-1    -pthread -I/usr/include/gl=
ib-2.0 -I/usr/lib64/glib-2.0/include   -fPIE -DPIE -m64 -mcx16 -D_GNU_SOU=
RCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wre=
dundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-str=
ict-aliasing -fno-common -fwrapv  -Wendif-labels -Wmissing-include-dirs -=
Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -=
Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype=
-limits -fstack-protector-all
> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -=
g=20
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          x86_64
> host big endian   no
> target list       x86_64-softmmu aarch64-softmmu
> tcg debug enabled no
> gprof enabled     no
> sparse enabled    no
> strip binaries    yes
> profiler          no
> static build      no
> pixman            system
> SDL support       yes (1.2.14)
> GTK support       no=20
> GTK GL support    no
> VTE support       no=20
> TLS priority      NORMAL
> GNUTLS support    no
> GNUTLS rnd        no
> libgcrypt         no
> libgcrypt kdf     no
> nettle            no=20
> nettle kdf        no
> libtasn1          no
> curses support    no
> virgl support     no
> curl support      no
> mingw32 support   no
> Audio drivers     oss
> Block whitelist (rw)=20
> Block whitelist (ro)=20
> VirtFS support    no
> VNC support       yes
> VNC SASL support  no
> VNC JPEG support  no
> VNC PNG support   no
> xen support       no
> brlapi support    no
> bluez  support    no
> Documentation     no
> PIE               yes
> vde support       no
> netmap support    no
> Linux AIO support no
> ATTR/XATTR support yes
> Install blobs     yes
> KVM support       yes
> COLO support      yes
> RDMA support      no
> TCG interpreter   no
> fdt support       yes
> preadv support    yes
> fdatasync         yes
> madvise           yes
> posix_madvise     yes
> libcap-ng support no
> vhost-net support yes
> vhost-scsi support yes
> vhost-vsock support yes
> Trace backends    log
> spice support     no=20
> rbd support       no
> xfsctl support    no
> smartcard support no
> libusb            no
> usb net redir     no
> OpenGL support    no
> OpenGL dmabufs    no
> libiscsi support  no
> libnfs support    no
> build guest agent yes
> QGA VSS support   no
> QGA w32 disk info no
> QGA MSI support   no
> seccomp support   no
> coroutine backend ucontext
> coroutine pool    yes
> debug stack usage no
> GlusterFS support no
> Archipelago support no
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   no
> TPM passthrough   yes
> QOM debugging     yes
> lzo support       no
> snappy support    no
> bzip2 support     no
> NUMA host support no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization no
> replication support yes
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     qemu-options.def
>   GEN     config-host.h
>   GEN     qapi-types.h
>   GEN     qmp-commands.h
>   GEN     qapi-visit.h
>   GEN     qapi-event.h
>   GEN     qmp-introspect.h
>   GEN     module_block.h
>   GEN     tests/test-qapi-types.h
>   GEN     tests/test-qapi-visit.h
>   GEN     tests/test-qmp-commands.h
>   GEN     tests/test-qapi-event.h
>   GEN     tests/test-qmp-introspect.h
>   GEN     trace/generated-tracers.h
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     config-all-devices.mak
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qapi-types.c
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>   GEN     qmp-introspect.c
>   GEN     qapi-visit.c
>   GEN     qapi-event.c
>   CC      qapi/qapi-visit-core.o
>   CC      qapi/qapi-dealloc-visitor.o
>   CC      qapi/qobject-input-visitor.o
>   CC      qapi/qobject-output-visitor.o
>   CC      qapi/qmp-registry.o
>   CC      qapi/qmp-dispatch.o
>   CC      qapi/string-input-visitor.o
>   CC      qapi/string-output-visitor.o
>   CC      qapi/qapi-clone-visitor.o
>   CC      qapi/opts-visitor.o
>   CC      qapi/qmp-event.o
>   CC      qapi/qapi-util.o
>   CC      qobject/qnull.o
>   CC      qobject/qint.o
>   CC      qobject/qstring.o
>   CC      qobject/qdict.o
>   CC      qobject/qlist.o
>   CC      qobject/qfloat.o
>   CC      qobject/qbool.o
>   CC      qobject/qjson.o
>   CC      qobject/qobject.o
>   CC      qobject/json-lexer.o
>   CC      qobject/json-streamer.o
>   CC      qobject/json-parser.o
>   GEN     trace/generated-tracers.c
>   CC      trace/control.o
>   CC      trace/qmp.o
>   CC      util/osdep.o
>   CC      util/cutils.o
>   CC      util/unicode.o
>   CC      util/qemu-timer-common.o
>   CC      util/bufferiszero.o
>   CC      util/lockcnt.o
>   CC      util/compatfd.o
>   CC      util/event_notifier-posix.o
>   CC      util/mmap-alloc.o
>   CC      util/oslib-posix.o
>   CC      util/qemu-openpty.o
>   CC      util/qemu-thread-posix.o
>   CC      util/memfd.o
>   CC      util/envlist.o
>   CC      util/path.o
>   CC      util/module.o
>   CC      util/bitmap.o
>   CC      util/bitops.o
>   CC      util/hbitmap.o
>   CC      util/fifo8.o
>   CC      util/acl.o
>   CC      util/error.o
>   CC      util/qemu-error.o
>   CC      util/id.o
>   CC      util/iov.o
>   CC      util/qemu-config.o
>   CC      util/qemu-sockets.o
>   CC      util/uri.o
>   CC      util/notify.o
>   CC      util/qemu-option.o
>   CC      util/qemu-progress.o
>   CC      util/hexdump.o
>   CC      util/crc32c.o
>   CC      util/uuid.o
>   CC      util/throttle.o
>   CC      util/getauxval.o
>   CC      util/readline.o
>   CC      util/rcu.o
>   CC      util/qemu-coroutine.o
>   CC      util/qemu-coroutine-lock.o
>   CC      util/qemu-coroutine-io.o
>   CC      util/qemu-coroutine-sleep.o
>   CC      util/coroutine-ucontext.o
>   CC      util/buffer.o
>   CC      util/timed-average.o
>   CC      util/base64.o
>   CC      util/log.o
>   CC      util/qdist.o
>   CC      util/qht.o
>   CC      util/range.o
>   CC      crypto/pbkdf-stub.o
>   CC      stubs/arch-query-cpu-def.o
>   CC      stubs/arch-query-cpu-model-expansion.o
>   CC      stubs/arch-query-cpu-model-comparison.o
>   CC      stubs/arch-query-cpu-model-baseline.o
>   CC      stubs/bdrv-next-monitor-owned.o
>   CC      stubs/blk-commit-all.o
>   CC      stubs/blockdev-close-all-bdrv-states.o
>   CC      stubs/clock-warp.o
>   CC      stubs/cpu-get-clock.o
>   CC      stubs/cpu-get-icount.o
>   CC      stubs/dump.o
>   CC      stubs/error-printf.o
>   CC      stubs/fdset-add-fd.o
>   CC      stubs/fdset-find-fd.o
>   CC      stubs/fdset-get-fd.o
>   CC      stubs/fdset-remove-fd.o
>   CC      stubs/gdbstub.o
>   CC      stubs/get-fd.o
>   CC      stubs/get-next-serial.o
>   CC      stubs/get-vm-name.o
>   CC      stubs/iothread.o
>   CC      stubs/iothread-lock.o
>   CC      stubs/is-daemonized.o
>   CC      stubs/machine-init-done.o
>   CC      stubs/migr-blocker.o
>   CC      stubs/mon-is-qmp.o
>   CC      stubs/monitor-init.o
>   CC      stubs/notify-event.o
>   CC      stubs/qtest.o
>   CC      stubs/replay.o
>   CC      stubs/replay-user.o
>   CC      stubs/reset.o
>   CC      stubs/runstate-check.o
>   CC      stubs/set-fd-handler.o
>   CC      stubs/slirp.o
>   CC      stubs/sysbus.o
>   CC      stubs/trace-control.o
>   CC      stubs/uuid.o
>   CC      stubs/vm-stop.o
>   CC      stubs/vmstate.o
>   CC      stubs/cpus.o
>   CC      stubs/kvm.o
>   CC      stubs/qmp_pc_dimm_device_list.o
>   CC      stubs/target-monitor-defs.o
>   CC      stubs/target-get-monitor-def.o
>   CC      stubs/vhost.o
>   CC      stubs/iohandler.o
>   CC      stubs/smbios_type_38.o
>   CC      stubs/ipmi.o
>   CC      stubs/pc_madt_cpu_entry.o
>   CC      stubs/migration-colo.o
>   CC      contrib/ivshmem-client/ivshmem-client.o
>   CC      contrib/ivshmem-client/main.o
>   CC      contrib/ivshmem-server/ivshmem-server.o
>   CC      contrib/ivshmem-server/main.o
>   CC      qemu-nbd.o
>   CC      async.o
>   CC      thread-pool.o
>   CC      block.o
>   CC      blockjob.o
>   CC      main-loop.o
>   CC      iohandler.o
>   CC      qemu-timer.o
>   CC      aio-posix.o
>   CC      qemu-io-cmds.o
>   CC      replication.o
>   CC      block/raw-format.o
>   CC      block/qcow.o
>   CC      block/vdi.o
>   CC      block/vmdk.o
>   CC      block/cloop.o
>   CC      block/bochs.o
>   CC      block/vpc.o
>   CC      block/vvfat.o
>   CC      block/dmg.o
>   CC      block/qcow2.o
>   CC      block/qcow2-refcount.o
>   CC      block/qcow2-cluster.o
>   CC      block/qcow2-snapshot.o
>   CC      block/qcow2-cache.o
>   CC      block/qed.o
>   CC      block/qed-gencb.o
>   CC      block/qed-l2-cache.o
>   CC      block/qed-table.o
>   CC      block/qed-cluster.o
>   CC      block/qed-check.o
>   CC      block/vhdx.o
>   CC      block/vhdx-endian.o
>   CC      block/vhdx-log.o
>   CC      block/quorum.o
>   CC      block/parallels.o
>   CC      block/blkdebug.o
>   CC      block/blkverify.o
>   CC      block/blkreplay.o
>   CC      block/block-backend.o
>   CC      block/snapshot.o
>   CC      block/qapi.o
>   CC      block/file-posix.o
>   CC      block/null.o
>   CC      block/mirror.o
>   CC      block/commit.o
>   CC      block/io.o
>   CC      block/throttle-groups.o
>   CC      block/nbd.o
>   CC      block/nbd-client.o
>   CC      block/sheepdog.o
>   CC      block/accounting.o
>   CC      block/dirty-bitmap.o
>   CC      block/write-threshold.o
>   CC      block/backup.o
>   CC      block/replication.o
>   CC      block/crypto.o
>   CC      nbd/server.o
>   CC      nbd/client.o
>   CC      nbd/common.o
>   CC      crypto/init.o
>   CC      crypto/hash.o
>   CC      crypto/hash-glib.o
>   CC      crypto/hmac.o
>   CC      crypto/hmac-glib.o
>   CC      crypto/aes.o
>   CC      crypto/desrfb.o
>   CC      crypto/cipher.o
>   CC      crypto/tlscreds.o
>   CC      crypto/tlscredsanon.o
>   CC      crypto/tlscredsx509.o
>   CC      crypto/tlssession.o
>   CC      crypto/secret.o
>   CC      crypto/random-platform.o
>   CC      crypto/pbkdf.o
>   CC      crypto/ivgen.o
>   CC      crypto/ivgen-essiv.o
>   CC      crypto/ivgen-plain.o
>   CC      crypto/ivgen-plain64.o
>   CC      crypto/afsplit.o
>   CC      crypto/xts.o
>   CC      crypto/block.o
>   CC      crypto/block-qcow.o
>   CC      crypto/block-luks.o
>   CC      io/channel.o
>   CC      io/channel-buffer.o
>   CC      io/channel-command.o
>   CC      io/channel-file.o
>   CC      io/channel-socket.o
>   CC      io/channel-watch.o
>   CC      io/channel-tls.o
>   CC      io/channel-websock.o
>   CC      io/channel-util.o
>   CC      io/task.o
>   CC      qom/object.o
>   CC      qom/qom-qobject.o
>   CC      qom/container.o
>   CC      qom/object_interfaces.o
>   GEN     qemu-img-cmds.h
>   CC      qemu-io.o
>   CC      qemu-bridge-helper.o
>   CC      blockdev.o
>   CC      blockdev-nbd.o
>   CC      qdev-monitor.o
>   CC      iothread.o
>   CC      device-hotplug.o
>   CC      qemu-char.o
>   CC      os-posix.o
>   CC      page_cache.o
>   CC      accel.o
>   CC      bt-vhci.o
>   CC      bt-host.o
>   CC      dma-helpers.o
>   CC      vl.o
>   CC      tpm.o
>   GEN     qmp-marshal.c
>   CC      device_tree.o
>   CC      hmp.o
>   CC      qmp.o
>   CC      audio/audio.o
>   CC      cpus-common.o
>   CC      audio/noaudio.o
>   CC      audio/wavaudio.o
>   CC      audio/mixeng.o
>   CC      audio/sdlaudio.o
>   CC      audio/ossaudio.o
>   CC      audio/wavcapture.o
>   CC      backends/rng.o
>   CC      backends/rng-egd.o
>   CC      backends/rng-random.o
>   CC      backends/msmouse.o
>   CC      backends/testdev.o
>   CC      backends/tpm.o
>   CC      backends/hostmem.o
>   CC      backends/hostmem-ram.o
>   CC      backends/hostmem-file.o
>   CC      backends/cryptodev.o
>   CC      backends/cryptodev-builtin.o
>   CC      block/stream.o
>   CC      disas/arm.o
>   CC      disas/i386.o
>   CC      fsdev/qemu-fsdev-opts.o
>   CC      fsdev/qemu-fsdev-dummy.o
>   CC      hw/acpi/core.o
>   CC      hw/acpi/piix4.o
>   CC      hw/acpi/pcihp.o
>   CC      hw/acpi/ich9.o
>   CC      hw/acpi/tco.o
>   CC      hw/acpi/cpu_hotplug.o
>   CC      hw/acpi/memory_hotplug.o
>   CC      hw/acpi/cpu.o
>   CC      hw/acpi/nvdimm.o
>   CC      hw/acpi/acpi_interface.o
>   CC      hw/acpi/bios-linker-loader.o
>   CC      hw/acpi/aml-build.o
>   CC      hw/audio/sb16.o
>   CC      hw/acpi/ipmi.o
>   CC      hw/audio/es1370.o
>   CC      hw/audio/ac97.o
>   CC      hw/audio/fmopl.o
>   CC      hw/audio/adlib.o
>   CC      hw/audio/gus.o
>   CC      hw/audio/gusemu_hal.o
>   CC      hw/audio/gusemu_mixer.o
>   CC      hw/audio/cs4231a.o
>   CC      hw/audio/intel-hda.o
>   CC      hw/audio/hda-codec.o
>   CC      hw/audio/pcspk.o
>   CC      hw/audio/wm8750.o
>   CC      hw/audio/pl041.o
>   CC      hw/audio/lm4549.o
>   CC      hw/audio/marvell_88w8618.o
>   CC      hw/block/block.o
>   CC      hw/block/cdrom.o
>   CC      hw/block/hd-geometry.o
>   CC      hw/block/fdc.o
>   CC      hw/block/m25p80.o
>   CC      hw/block/nand.o
>   CC      hw/block/pflash_cfi01.o
>   CC      hw/block/pflash_cfi02.o
>   CC      hw/block/ecc.o
>   CC      hw/block/onenand.o
>   CC      hw/block/nvme.o
>   CC      hw/bt/core.o
>   CC      hw/bt/sdp.o
>   CC      hw/bt/l2cap.o
>   CC      hw/bt/hci.o
>   CC      hw/bt/hid.o
>   CC      hw/bt/hci-csr.o
>   CC      hw/char/ipoctal232.o
>   CC      hw/char/parallel.o
>   CC      hw/char/serial-isa.o
>   CC      hw/char/pl011.o
>   CC      hw/char/serial.o
>   CC      hw/char/virtio-console.o
>   CC      hw/char/serial-pci.o
>   CC      hw/char/cadence_uart.o
>   CC      hw/char/debugcon.o
>   CC      hw/char/imx_serial.o
>   CC      hw/core/qdev.o
>   CC      hw/core/qdev-properties.o
>   CC      hw/core/bus.o
>   CC      hw/core/fw-path-provider.o
>   CC      hw/core/irq.o
>   CC      hw/core/hotplug.o
>   CC      hw/core/ptimer.o
>   CC      hw/core/sysbus.o
>   CC      hw/core/machine.o
>   CC      hw/core/null-machine.o
>   CC      hw/core/loader.o
>   CC      hw/core/qdev-properties-system.o
>   CC      hw/core/register.o
>   CC      hw/core/or-irq.o
>   CC      hw/core/platform-bus.o
>   CC      hw/display/ads7846.o
>   CC      hw/display/cirrus_vga.o
>   CC      hw/display/pl110.o
>   CC      hw/display/ssd0303.o
>   CC      hw/display/ssd0323.o
>   CC      hw/display/vga-pci.o
>   CC      hw/display/vga-isa.o
>   CC      hw/display/vmware_vga.o
>   CC      hw/display/blizzard.o
>   CC      hw/display/exynos4210_fimd.o
>   CC      hw/display/framebuffer.o
>   CC      hw/display/tc6393xb.o
>   CC      hw/dma/pl080.o
>   CC      hw/dma/pl330.o
>   CC      hw/dma/xlnx-zynq-devcfg.o
>   CC      hw/dma/i8257.o
>   CC      hw/gpio/max7310.o
>   CC      hw/gpio/pl061.o
>   CC      hw/gpio/zaurus.o
>   CC      hw/gpio/gpio_key.o
>   CC      hw/i2c/core.o
>   CC      hw/i2c/smbus.o
>   CC      hw/i2c/smbus_eeprom.o
>   CC      hw/i2c/i2c-ddc.o
>   CC      hw/i2c/versatile_i2c.o
>   CC      hw/i2c/smbus_ich9.o
>   CC      hw/i2c/pm_smbus.o
>   CC      hw/i2c/bitbang_i2c.o
>   CC      hw/i2c/exynos4210_i2c.o
>   CC      hw/i2c/imx_i2c.o
>   CC      hw/i2c/aspeed_i2c.o
>   CC      hw/ide/core.o
>   CC      hw/ide/atapi.o
>   CC      hw/ide/qdev.o
>   CC      hw/ide/pci.o
>   CC      hw/ide/isa.o
>   CC      hw/ide/piix.o
>   CC      hw/ide/microdrive.o
>   CC      hw/ide/ahci.o
>   CC      hw/ide/ich.o
>   CC      hw/input/hid.o
>   CC      hw/input/pl050.o
>   CC      hw/input/pckbd.o
>   CC      hw/input/lm832x.o
>   CC      hw/input/ps2.o
>   CC      hw/input/stellaris_input.o
>   CC      hw/input/tsc2005.o
>   CC      hw/input/vmmouse.o
>   CC      hw/intc/i8259_common.o
>   CC      hw/input/virtio-input-hid.o
>   CC      hw/input/virtio-input.o
>   CC      hw/input/virtio-input-host.o
>   CC      hw/intc/i8259.o
>   CC      hw/intc/pl190.o
>   CC      hw/intc/imx_avic.o
>   CC      hw/intc/realview_gic.o
>   CC      hw/intc/ioapic_common.o
>   CC      hw/intc/arm_gic_common.o
>   CC      hw/intc/arm_gic.o
>   CC      hw/intc/arm_gicv2m.o
>   CC      hw/intc/arm_gicv3_common.o
>   CC      hw/intc/arm_gicv3.o
>   CC      hw/intc/arm_gicv3_dist.o
>   CC      hw/intc/arm_gicv3_redist.o
>   CC      hw/intc/arm_gicv3_its_common.o
>   CC      hw/intc/intc.o
>   CC      hw/ipack/ipack.o
>   CC      hw/ipack/tpci200.o
>   CC      hw/ipmi/ipmi.o
>   CC      hw/ipmi/ipmi_bmc_sim.o
>   CC      hw/ipmi/ipmi_bmc_extern.o
>   CC      hw/ipmi/isa_ipmi_kcs.o
>   CC      hw/ipmi/isa_ipmi_bt.o
>   CC      hw/isa/isa-bus.o
>   CC      hw/isa/apm.o
>   CC      hw/mem/pc-dimm.o
>   CC      hw/mem/nvdimm.o
>   CC      hw/misc/applesmc.o
>   CC      hw/misc/max111x.o
>   CC      hw/misc/tmp105.o
>   CC      hw/misc/debugexit.o
>   CC      hw/misc/sga.o
>   CC      hw/misc/pc-testdev.o
>   CC      hw/misc/pci-testdev.o
>   CC      hw/misc/arm_l2x0.o
>   CC      hw/misc/arm_integrator_debug.o
>   CC      hw/misc/a9scu.o
>   CC      hw/misc/arm11scu.o
>   CC      hw/net/ne2000.o
>   CC      hw/net/eepro100.o
>   CC      hw/net/pcnet-pci.o
>   CC      hw/net/pcnet.o
>   CC      hw/net/e1000.o
>   CC      hw/net/e1000x_common.o
>   CC      hw/net/net_tx_pkt.o
>   CC      hw/net/net_rx_pkt.o
>   CC      hw/net/e1000e.o
>   CC      hw/net/e1000e_core.o
>   CC      hw/net/rtl8139.o
>   CC      hw/net/smc91c111.o
>   CC      hw/net/vmxnet3.o
>   CC      hw/net/lan9118.o
>   CC      hw/net/ne2000-isa.o
>   CC      hw/net/allwinner_emac.o
>   CC      hw/net/xgmac.o
>   CC      hw/net/imx_fec.o
>   CC      hw/net/cadence_gem.o
>   CC      hw/net/stellaris_enet.o
>   CC      hw/net/rocker/rocker.o
>   CC      hw/net/rocker/rocker_fp.o
>   CC      hw/net/rocker/rocker_desc.o
>   CC      hw/net/rocker/rocker_world.o
>   CC      hw/net/rocker/rocker_of_dpa.o
>   CC      hw/nvram/eeprom93xx.o
>   CC      hw/nvram/fw_cfg.o
>   CC      hw/nvram/chrp_nvram.o
>   CC      hw/pci-bridge/pci_bridge_dev.o
>   CC      hw/pci-bridge/pci_expander_bridge.o
>   CC      hw/pci-bridge/xio3130_upstream.o
>   CC      hw/pci-bridge/xio3130_downstream.o
>   CC      hw/pci-bridge/ioh3420.o
>   CC      hw/pci-bridge/i82801b11.o
>   CC      hw/pci-host/pam.o
>   CC      hw/pci-host/versatile.o
>   CC      hw/pci-host/piix.o
>   CC      hw/pci-host/gpex.o
>   CC      hw/pci-host/q35.o
>   CC      hw/pci/pci_bridge.o
>   CC      hw/pci/pci.o
>   CC      hw/pci/msix.o
>   CC      hw/pci/msi.o
>   CC      hw/pci/shpc.o
> /tmp/qemu-test/src/hw/nvram/fw_cfg.c: In function =E2=80=98fw_cfg_dma_t=
ransfer=E2=80=99:
> /tmp/qemu-test/src/hw/nvram/fw_cfg.c:329: warning: =E2=80=98read=E2=80=99=
 may be used uninitialized in this function
>   CC      hw/pci/slotid_cap.o
>   CC      hw/pci/pcie_host.o
>   CC      hw/pci/pci_host.o
>   CC      hw/pci/pcie.o
>   CC      hw/pci/pcie_aer.o
>   CC      hw/pci/pci-stub.o
>   CC      hw/pci/pcie_port.o
>   CC      hw/pcmcia/pcmcia.o
>   CC      hw/scsi/scsi-disk.o
>   CC      hw/scsi/scsi-generic.o
>   CC      hw/scsi/scsi-bus.o
>   CC      hw/scsi/lsi53c895a.o
>   CC      hw/scsi/mptsas.o
>   CC      hw/scsi/mptconfig.o
>   CC      hw/scsi/mptendian.o
>   CC      hw/scsi/megasas.o
>   CC      hw/scsi/vmw_pvscsi.o
>   CC      hw/scsi/esp.o
>   CC      hw/scsi/esp-pci.o
>   CC      hw/sd/pl181.o
>   CC      hw/sd/ssi-sd.o
>   CC      hw/sd/core.o
>   CC      hw/sd/sd.o
>   CC      hw/sd/sdhci.o
>   CC      hw/smbios/smbios.o
>   CC      hw/smbios/smbios_type_38.o
>   CC      hw/ssi/ssi.o
>   CC      hw/ssi/pl022.o
>   CC      hw/ssi/xilinx_spips.o
>   CC      hw/ssi/aspeed_smc.o
>   CC      hw/ssi/stm32f2xx_spi.o
>   CC      hw/timer/arm_timer.o
>   CC      hw/timer/arm_mptimer.o
>   CC      hw/timer/a9gtimer.o
>   CC      hw/timer/cadence_ttc.o
>   CC      hw/timer/ds1338.o
>   CC      hw/timer/hpet.o
>   CC      hw/timer/i8254.o
>   CC      hw/timer/i8254_common.o
>   CC      hw/timer/twl92230.o
>   CC      hw/timer/pl031.o
>   CC      hw/timer/imx_epit.o
>   CC      hw/timer/imx_gpt.o
>   CC      hw/timer/stm32f2xx_timer.o
>   CC      hw/timer/aspeed_timer.o
>   CC      hw/tpm/tpm_tis.o
>   CC      hw/tpm/tpm_passthrough.o
>   CC      hw/tpm/tpm_util.o
>   CC      hw/usb/core.o
>   CC      hw/usb/combined-packet.o
>   CC      hw/usb/bus.o
>   CC      hw/usb/libhw.o
>   CC      hw/usb/desc.o
>   CC      hw/usb/hcd-uhci.o
>   CC      hw/usb/desc-msos.o
>   CC      hw/usb/hcd-ohci.o
>   CC      hw/usb/hcd-ehci.o
>   CC      hw/usb/hcd-ehci-pci.o
>   CC      hw/usb/hcd-ehci-sysbus.o
>   CC      hw/usb/hcd-xhci.o
>   CC      hw/usb/hcd-musb.o
>   CC      hw/usb/dev-hub.o
>   CC      hw/usb/dev-hid.o
>   CC      hw/usb/dev-wacom.o
>   CC      hw/usb/dev-storage.o
>   CC      hw/usb/dev-uas.o
>   CC      hw/usb/dev-audio.o
>   CC      hw/usb/dev-network.o
>   CC      hw/usb/dev-serial.o
>   CC      hw/usb/dev-bluetooth.o
>   CC      hw/usb/dev-smartcard-reader.o
>   CC      hw/usb/dev-mtp.o
>   CC      hw/usb/host-stub.o
>   CC      hw/virtio/virtio-pci.o
>   CC      hw/virtio/virtio-rng.o
>   CC      hw/virtio/virtio-bus.o
>   CC      hw/virtio/virtio-mmio.o
>   CC      hw/watchdog/watchdog.o
>   CC      hw/watchdog/wdt_i6300esb.o
>   CC      hw/watchdog/wdt_ib700.o
>   CC      migration/migration.o
>   CC      migration/socket.o
>   CC      migration/fd.o
>   CC      migration/exec.o
>   CC      migration/tls.o
>   CC      migration/colo-comm.o
>   CC      migration/colo.o
>   CC      migration/colo-failover.o
>   CC      migration/vmstate.o
>   CC      migration/qemu-file.o
>   CC      migration/qemu-file-channel.o
>   CC      migration/xbzrle.o
>   CC      migration/postcopy-ram.o
>   CC      migration/qjson.o
>   CC      migration/block.o
>   CC      net/net.o
>   CC      net/queue.o
>   CC      net/checksum.o
>   CC      net/util.o
>   CC      net/hub.o
>   CC      net/socket.o
>   CC      net/dump.o
>   CC      net/eth.o
>   CC      net/l2tpv3.o
>   CC      net/tap.o
>   CC      net/vhost-user.o
>   CC      net/tap-linux.o
>   CC      net/slirp.o
>   CC      net/filter.o
>   CC      net/filter-buffer.o
>   CC      net/colo-compare.o
>   CC      net/filter-mirror.o
>   CC      net/colo.o
>   CC      net/filter-rewriter.o
>   CC      net/filter-replay.o
>   CC      qom/cpu.o
>   CC      replay/replay.o
>   CC      replay/replay-internal.o
>   CC      replay/replay-events.o
>   CC      replay/replay-time.o
>   CC      replay/replay-input.o
>   CC      replay/replay-char.o
>   CC      replay/replay-snapshot.o
>   CC      replay/replay-net.o
> /tmp/qemu-test/src/replay/replay-internal.c: In function =E2=80=98repla=
y_put_array=E2=80=99:
> /tmp/qemu-test/src/replay/replay-internal.c:65: warning: ignoring retur=
n value of =E2=80=98fwrite=E2=80=99, declared with attribute warn_unused_=
result
>   CC      slirp/cksum.o
>   CC      slirp/if.o
>   CC      slirp/ip_icmp.o
>   CC      slirp/ip6_icmp.o
>   CC      slirp/ip6_input.o
>   CC      slirp/ip6_output.o
>   CC      slirp/ip_input.o
>   CC      slirp/ip_output.o
>   CC      slirp/dnssearch.o
>   CC      slirp/dhcpv6.o
>   CC      slirp/slirp.o
>   CC      slirp/mbuf.o
>   CC      slirp/misc.o
>   CC      slirp/sbuf.o
>   CC      slirp/socket.o
>   CC      slirp/tcp_input.o
>   CC      slirp/tcp_output.o
>   CC      slirp/tcp_subr.o
>   CC      slirp/tcp_timer.o
>   CC      slirp/udp.o
>   CC      slirp/udp6.o
>   CC      slirp/bootp.o
>   CC      slirp/tftp.o
>   CC      slirp/arp_table.o
>   CC      slirp/ndp_table.o
>   CC      ui/keymaps.o
>   CC      ui/console.o
>   CC      ui/cursor.o
>   CC      ui/qemu-pixman.o
>   CC      ui/input.o
>   CC      ui/input-keymap.o
>   CC      ui/input-legacy.o
>   CC      ui/input-linux.o
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
>   CC      ui/sdl.o
>   CC      ui/sdl_zoom.o
>   CC      ui/x_keymap.o
>   CC      ui/vnc.o
>   CC      ui/vnc-enc-zlib.o
>   CC      ui/vnc-enc-hextile.o
>   CC      ui/vnc-enc-tight.o
>   CC      ui/vnc-palette.o
>   CC      ui/vnc-enc-zrle.o
>   CC      ui/vnc-auth-vencrypt.o
>   CC      ui/vnc-ws.o
>   CC      ui/vnc-jobs.o
>   LINK    tests/qemu-iotests/socket_scm_helper
>   CC      qga/commands.o
>   CC      qga/guest-agent-command-state.o
>   CC      qga/main.o
>   CC      qga/channel-posix.o
>   CC      qga/commands-posix.o
>   CC      qga/qapi-generated/qga-qapi-types.o
>   CC      qga/qapi-generated/qga-qapi-visit.o
>   CC      qga/qapi-generated/qga-qmp-marshal.o
>   CC      qmp-introspect.o
>   CC      qapi-types.o
>   CC      qapi-visit.o
>   CC      qapi-event.o
>   AR      libqemustub.a
>   CC      qemu-img.o
>   CC      qmp-marshal.o
>   CC      trace/generated-tracers.o
>   AR      libqemuutil.a
>   AS      optionrom/multiboot.o
>   AS      optionrom/linuxboot.o
>   CC      optionrom/linuxboot_dma.o
>   AS      optionrom/kvmvapic.o
> cc: unrecognized option '-no-integrated-as'
> cc: unrecognized option '-no-integrated-as'
>   BUILD   optionrom/linuxboot_dma.img
>   BUILD   optionrom/linuxboot_dma.raw
>   SIGN    optionrom/linuxboot_dma.bin
>   BUILD   optionrom/multiboot.img
>   BUILD   optionrom/linuxboot.img
>   BUILD   optionrom/kvmvapic.img
>   BUILD   optionrom/multiboot.raw
>   BUILD   optionrom/linuxboot.raw
>   BUILD   optionrom/kvmvapic.raw
>   SIGN    optionrom/multiboot.bin
>   SIGN    optionrom/linuxboot.bin
>   SIGN    optionrom/kvmvapic.bin
>   LINK    ivshmem-client
>   LINK    ivshmem-server
>   LINK    qemu-nbd
>   LINK    qemu-img
>   LINK    qemu-io
>   LINK    qemu-bridge-helper
>   LINK    qemu-ga
>   GEN     aarch64-softmmu/hmp-commands.h
>   GEN     aarch64-softmmu/hmp-commands-info.h
>   GEN     aarch64-softmmu/config-target.h
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/hmp-commands-info.h
>   GEN     x86_64-softmmu/config-target.h
>   CC      aarch64-softmmu/exec.o
>   CC      aarch64-softmmu/translate-all.o
>   CC      aarch64-softmmu/cpu-exec.o
>   CC      aarch64-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/translate-common.o
>   CC      aarch64-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/cpu-exec-common.o
>   CC      aarch64-softmmu/tcg/optimize.o
>   CC      aarch64-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/disas.o
>   CC      aarch64-softmmu/tcg-runtime.o
>   GEN     aarch64-softmmu/gdbstub-xml.c
>   CC      aarch64-softmmu/kvm-stub.o
>   CC      aarch64-softmmu/arch_init.o
>   CC      aarch64-softmmu/cpus.o
>   CC      aarch64-softmmu/monitor.o
>   CC      aarch64-softmmu/gdbstub.o
>   CC      aarch64-softmmu/balloon.o
>   CC      aarch64-softmmu/ioport.o
>   CC      aarch64-softmmu/numa.o
>   CC      aarch64-softmmu/qtest.o
>   CC      aarch64-softmmu/bootdevice.o
>   CC      aarch64-softmmu/memory.o
>   CC      aarch64-softmmu/cputlb.o
>   CC      aarch64-softmmu/memory_mapping.o
>   CC      aarch64-softmmu/dump.o
>   CC      aarch64-softmmu/migration/ram.o
>   CC      aarch64-softmmu/xen-common-stub.o
>   CC      aarch64-softmmu/migration/savevm.o
>   CC      aarch64-softmmu/xen-hvm-stub.o
>   CC      aarch64-softmmu/hw/adc/stm32f2xx_adc.o
>   CC      aarch64-softmmu/hw/block/virtio-blk.o
>   CC      aarch64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      aarch64-softmmu/hw/char/exynos4210_uart.o
>   CC      aarch64-softmmu/hw/char/stm32f2xx_usart.o
>   CC      aarch64-softmmu/hw/char/omap_uart.o
>   CC      aarch64-softmmu/hw/char/digic-uart.o
>   CC      aarch64-softmmu/hw/char/bcm2835_aux.o
>   CC      aarch64-softmmu/hw/char/virtio-serial-bus.o
>   CC      aarch64-softmmu/hw/core/nmi.o
>   CC      aarch64-softmmu/hw/core/generic-loader.o
>   CC      aarch64-softmmu/hw/cpu/arm11mpcore.o
>   CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>   CC      aarch64-softmmu/hw/cpu/a9mpcore.o
>   CC      aarch64-softmmu/hw/cpu/a15mpcore.o
>   CC      aarch64-softmmu/hw/cpu/core.o
>   CC      aarch64-softmmu/hw/display/omap_dss.o
>   CC      aarch64-softmmu/hw/display/omap_lcdc.o
>   CC      aarch64-softmmu/hw/display/pxa2xx_lcd.o
>   CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>   CC      aarch64-softmmu/hw/display/vga.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      aarch64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      x86_64-softmmu/exec.o
>   CC      x86_64-softmmu/translate-all.o
>   CC      aarch64-softmmu/hw/display/dpcd.o
>   CC      x86_64-softmmu/cpu-exec.o
>   CC      x86_64-softmmu/translate-common.o
>   CC      aarch64-softmmu/hw/display/xlnx_dp.o
>   CC      aarch64-softmmu/hw/dma/xlnx_dpdma.o
>   CC      x86_64-softmmu/cpu-exec-common.o
>   CC      x86_64-softmmu/tcg/tcg.o
>   CC      x86_64-softmmu/tcg/tcg-op.o
>   CC      aarch64-softmmu/hw/dma/omap_dma.o
>   CC      aarch64-softmmu/hw/dma/soc_dma.o
>   CC      x86_64-softmmu/tcg/optimize.o
>   CC      x86_64-softmmu/tcg/tcg-common.o
>   CC      aarch64-softmmu/hw/dma/pxa2xx_dma.o
>   CC      aarch64-softmmu/hw/dma/bcm2835_dma.o
>   CC      x86_64-softmmu/fpu/softfloat.o
>   CC      aarch64-softmmu/hw/gpio/omap_gpio.o
>   CC      x86_64-softmmu/disas.o
>   CC      aarch64-softmmu/hw/gpio/imx_gpio.o
>   CC      x86_64-softmmu/tcg-runtime.o
>   CC      aarch64-softmmu/hw/i2c/omap_i2c.o
>   CC      x86_64-softmmu/arch_init.o
>   CC      x86_64-softmmu/cpus.o
>   CC      x86_64-softmmu/monitor.o
>   CC      x86_64-softmmu/gdbstub.o
>   CC      x86_64-softmmu/balloon.o
>   CC      aarch64-softmmu/hw/input/pxa2xx_keypad.o
>   CC      aarch64-softmmu/hw/input/tsc210x.o
>   CC      x86_64-softmmu/ioport.o
>   CC      aarch64-softmmu/hw/intc/armv7m_nvic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_gic.o
>   CC      aarch64-softmmu/hw/intc/exynos4210_combiner.o
>   CC      x86_64-softmmu/numa.o
>   CC      aarch64-softmmu/hw/intc/omap_intc.o
>   CC      aarch64-softmmu/hw/intc/bcm2835_ic.o
>   CC      x86_64-softmmu/qtest.o
>   CC      aarch64-softmmu/hw/intc/bcm2836_control.o
>   CC      x86_64-softmmu/bootdevice.o
>   CC      aarch64-softmmu/hw/intc/allwinner-a10-pic.o
>   CC      x86_64-softmmu/kvm-all.o
>   CC      aarch64-softmmu/hw/intc/aspeed_vic.o
>   CC      x86_64-softmmu/memory.o
>   CC      x86_64-softmmu/cputlb.o
>   CC      aarch64-softmmu/hw/intc/arm_gicv3_cpuif.o
>   CC      aarch64-softmmu/hw/misc/ivshmem.o
>   CC      x86_64-softmmu/memory_mapping.o
>   CC      aarch64-softmmu/hw/misc/arm_sysctl.o
>   CC      aarch64-softmmu/hw/misc/cbus.o
>   CC      x86_64-softmmu/dump.o
>   CC      aarch64-softmmu/hw/misc/exynos4210_pmu.o
>   CC      aarch64-softmmu/hw/misc/imx_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx31_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx25_ccm.o
>   CC      x86_64-softmmu/migration/ram.o
>   CC      aarch64-softmmu/hw/misc/imx6_ccm.o
>   CC      aarch64-softmmu/hw/misc/imx6_src.o
>   CC      x86_64-softmmu/migration/savevm.o
>   CC      x86_64-softmmu/xen-common-stub.o
>   CC      x86_64-softmmu/xen-hvm-stub.o
>   CC      aarch64-softmmu/hw/misc/mst_fpga.o
>   CC      aarch64-softmmu/hw/misc/omap_clk.o
>   CC      aarch64-softmmu/hw/misc/omap_gpmc.o
>   CC      aarch64-softmmu/hw/misc/omap_l4.o
>   CC      x86_64-softmmu/hw/block/virtio-blk.o
>   CC      aarch64-softmmu/hw/misc/omap_sdrc.o
>   CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
>   CC      aarch64-softmmu/hw/misc/omap_tap.o
>   CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_mbox.o
>   CC      x86_64-softmmu/hw/core/nmi.o
>   CC      aarch64-softmmu/hw/misc/bcm2835_property.o
>   CC      aarch64-softmmu/hw/misc/zynq_slcr.o
>   CC      x86_64-softmmu/hw/core/generic-loader.o
>   CC      x86_64-softmmu/hw/cpu/core.o
>   CC      x86_64-softmmu/hw/display/vga.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
>   CC      aarch64-softmmu/hw/misc/zynq-xadc.o
>   CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
>   CC      aarch64-softmmu/hw/misc/stm32f2xx_syscfg.o
>   CC      x86_64-softmmu/hw/display/virtio-vga.o
>   CC      x86_64-softmmu/hw/intc/apic.o
>   CC      aarch64-softmmu/hw/misc/edu.o
>   CC      aarch64-softmmu/hw/misc/auxbus.o
>   CC      x86_64-softmmu/hw/intc/apic_common.o
>   CC      aarch64-softmmu/hw/misc/aspeed_scu.o
>   CC      aarch64-softmmu/hw/misc/aspeed_sdmc.o
>   CC      x86_64-softmmu/hw/intc/ioapic.o
>   CC      x86_64-softmmu/hw/isa/lpc_ich9.o
>   CC      aarch64-softmmu/hw/net/vhost_net.o
>   CC      x86_64-softmmu/hw/misc/vmport.o
>   CC      aarch64-softmmu/hw/net/virtio-net.o
>   CC      aarch64-softmmu/hw/pcmcia/pxa2xx.o
>   CC      x86_64-softmmu/hw/misc/ivshmem.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>   CC      x86_64-softmmu/hw/misc/pvpanic.o
>   CC      x86_64-softmmu/hw/misc/edu.o
>   CC      x86_64-softmmu/hw/misc/hyperv_testdev.o
>   CC      x86_64-softmmu/hw/net/virtio-net.o
>   CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      x86_64-softmmu/hw/net/vhost_net.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
>   CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>   CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>   CC      aarch64-softmmu/hw/sd/omap_mmc.o
>   CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
>   CC      x86_64-softmmu/hw/timer/mc146818rtc.o
>   CC      aarch64-softmmu/hw/ssi/omap_spi.o
>   CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>   CC      x86_64-softmmu/hw/vfio/common.o
>   CC      x86_64-softmmu/hw/vfio/pci.o
>   CC      aarch64-softmmu/hw/ssi/imx_spi.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>   CC      x86_64-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>   CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>   CC      x86_64-softmmu/hw/vfio/platform.o
>   CC      x86_64-softmmu/hw/vfio/calxeda-xgmac.o
>   CC      x86_64-softmmu/hw/vfio/amd-xgbe.o
>   CC      x86_64-softmmu/hw/vfio/spapr.o
>   CC      x86_64-softmmu/hw/virtio/virtio.o
>   CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
>   CC      x86_64-softmmu/hw/virtio/vhost.o
>   CC      aarch64-softmmu/hw/timer/omap_gptimer.o
>   CC      x86_64-softmmu/hw/virtio/vhost-backend.o
>   CC      x86_64-softmmu/hw/virtio/vhost-user.o
>   CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/timer/omap_synctimer.o
>   CC      aarch64-softmmu/hw/timer/pxa2xx_timer.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/timer/digic-timer.o
>   CC      x86_64-softmmu/hw/i386/multiboot.o
>   CC      x86_64-softmmu/hw/i386/pc.o
>   CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>   CC      x86_64-softmmu/hw/i386/pc_piix.o
>   CC      x86_64-softmmu/hw/i386/pc_q35.o
>   CC      aarch64-softmmu/hw/usb/tusb6010.o
>   CC      x86_64-softmmu/hw/i386/pc_sysfw.o
>   CC      x86_64-softmmu/hw/i386/x86-iommu.o
>   CC      aarch64-softmmu/hw/vfio/common.o
>   CC      x86_64-softmmu/hw/i386/intel_iommu.o
>   CC      x86_64-softmmu/hw/i386/amd_iommu.o
>   CC      x86_64-softmmu/hw/i386/kvmvapic.o
>   CC      x86_64-softmmu/hw/i386/acpi-build.o
>   CC      x86_64-softmmu/hw/i386/pci-assign-load-rom.o
>   CC      x86_64-softmmu/hw/i386/kvm/clock.o
>   CC      x86_64-softmmu/hw/i386/kvm/apic.o
>   CC      x86_64-softmmu/hw/i386/kvm/i8259.o
> /tmp/qemu-test/src/hw/i386/pc_piix.c: In function =E2=80=98igd_passthro=
ugh_isa_bridge_create=E2=80=99:
> /tmp/qemu-test/src/hw/i386/pc_piix.c:1046: warning: =E2=80=98pch_rev_id=
=E2=80=99 may be used uninitialized in this function
>   CC      x86_64-softmmu/hw/i386/kvm/ioapic.o
>   CC      x86_64-softmmu/hw/i386/kvm/i8254.o
>   CC      aarch64-softmmu/hw/vfio/pci.o
>   CC      x86_64-softmmu/hw/i386/kvm/pci-assign.o
>   CC      x86_64-softmmu/target/i386/translate.o
>   CC      aarch64-softmmu/hw/vfio/pci-quirks.o
>   CC      aarch64-softmmu/hw/vfio/platform.o
>   CC      aarch64-softmmu/hw/vfio/calxeda-xgmac.o
> /tmp/qemu-test/src/hw/i386/acpi-build.c: In function =E2=80=98build_app=
end_pci_bus_devices=E2=80=99:
> /tmp/qemu-test/src/hw/i386/acpi-build.c:496: warning: =E2=80=98notify_m=
ethod=E2=80=99 may be used uninitialized in this function
>   CC      aarch64-softmmu/hw/vfio/amd-xgbe.o
>   CC      x86_64-softmmu/target/i386/helper.o
>   CC      x86_64-softmmu/target/i386/cpu.o
>   CC      aarch64-softmmu/hw/vfio/spapr.o
>   CC      x86_64-softmmu/target/i386/bpt_helper.o
>   CC      x86_64-softmmu/target/i386/excp_helper.o
>   CC      aarch64-softmmu/hw/virtio/virtio.o
>   CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
>   CC      aarch64-softmmu/hw/virtio/vhost.o
>   CC      x86_64-softmmu/target/i386/fpu_helper.o
>   CC      aarch64-softmmu/hw/virtio/vhost-backend.o
>   CC      aarch64-softmmu/hw/virtio/vhost-user.o
>   CC      x86_64-softmmu/target/i386/cc_helper.o
>   CC      x86_64-softmmu/target/i386/int_helper.o
>   CC      aarch64-softmmu/hw/virtio/vhost-vsock.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto.o
>   CC      aarch64-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      x86_64-softmmu/target/i386/svm_helper.o
>   CC      aarch64-softmmu/hw/arm/boot.o
>   CC      x86_64-softmmu/target/i386/smm_helper.o
>   CC      x86_64-softmmu/target/i386/misc_helper.o
>   CC      x86_64-softmmu/target/i386/mem_helper.o
>   CC      aarch64-softmmu/hw/arm/collie.o
>   CC      x86_64-softmmu/target/i386/seg_helper.o
>   CC      aarch64-softmmu/hw/arm/exynos4_boards.o
>   CC      x86_64-softmmu/target/i386/mpx_helper.o
>   CC      x86_64-softmmu/target/i386/gdbstub.o
>   CC      aarch64-softmmu/hw/arm/gumstix.o
>   CC      x86_64-softmmu/target/i386/machine.o
>   CC      x86_64-softmmu/target/i386/arch_memory_mapping.o
>   CC      x86_64-softmmu/target/i386/arch_dump.o
>   CC      x86_64-softmmu/target/i386/monitor.o
>   CC      x86_64-softmmu/target/i386/kvm.o
>   CC      aarch64-softmmu/hw/arm/highbank.o
>   CC      x86_64-softmmu/target/i386/hyperv.o
>   CC      aarch64-softmmu/hw/arm/digic_boards.o
>   CC      aarch64-softmmu/hw/arm/integratorcp.o
>   CC      aarch64-softmmu/hw/arm/mainstone.o
>   CC      aarch64-softmmu/hw/arm/musicpal.o
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/hw/arm/nseries.o
>   CC      aarch64-softmmu/hw/arm/omap_sx1.o
>   CC      x86_64-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/hw/arm/palm.o
>   CC      aarch64-softmmu/hw/arm/realview.o
>   CC      aarch64-softmmu/hw/arm/spitz.o
>   CC      aarch64-softmmu/hw/arm/stellaris.o
>   CC      aarch64-softmmu/hw/arm/tosa.o
>   CC      aarch64-softmmu/hw/arm/versatilepb.o
>   CC      aarch64-softmmu/hw/arm/vexpress.o
>   CC      aarch64-softmmu/hw/arm/virt.o
>   CC      aarch64-softmmu/hw/arm/xilinx_zynq.o
>   CC      aarch64-softmmu/hw/arm/z2.o
>   CC      aarch64-softmmu/hw/arm/virt-acpi-build.o
>   CC      aarch64-softmmu/hw/arm/netduino2.o
>   CC      aarch64-softmmu/hw/arm/sysbus-fdt.o
>   CC      aarch64-softmmu/hw/arm/armv7m.o
>   CC      aarch64-softmmu/hw/arm/exynos4210.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_gpio.o
>   CC      aarch64-softmmu/hw/arm/pxa2xx_pic.o
>   CC      aarch64-softmmu/hw/arm/digic.o
>   CC      aarch64-softmmu/hw/arm/omap1.o
>   CC      aarch64-softmmu/hw/arm/omap2.o
>   CC      aarch64-softmmu/hw/arm/strongarm.o
>   CC      aarch64-softmmu/hw/arm/allwinner-a10.o
>   CC      aarch64-softmmu/hw/arm/cubieboard.o
>   CC      aarch64-softmmu/hw/arm/bcm2836.o
>   CC      aarch64-softmmu/hw/arm/bcm2835_peripherals.o
>   CC      aarch64-softmmu/hw/arm/raspi.o
>   CC      aarch64-softmmu/hw/arm/stm32f205_soc.o
>   CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>   CC      aarch64-softmmu/hw/arm/xlnx-ep108.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx25.o
>   CC      aarch64-softmmu/hw/arm/imx25_pdk.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx31.o
>   CC      aarch64-softmmu/hw/arm/kzm.o
>   CC      aarch64-softmmu/hw/arm/fsl-imx6.o
>   CC      aarch64-softmmu/hw/arm/sabrelite.o
>   CC      aarch64-softmmu/hw/arm/aspeed_soc.o
>   CC      aarch64-softmmu/hw/arm/aspeed.o
>   CC      aarch64-softmmu/target/arm/arm-semi.o
>   CC      aarch64-softmmu/target/arm/machine.o
>   CC      aarch64-softmmu/target/arm/psci.o
>   CC      aarch64-softmmu/target/arm/arch_dump.o
>   CC      aarch64-softmmu/target/arm/monitor.o
>   CC      aarch64-softmmu/target/arm/kvm-stub.o
>   CC      aarch64-softmmu/target/arm/translate.o
>   CC      aarch64-softmmu/target/arm/op_helper.o
>   CC      aarch64-softmmu/target/arm/helper.o
>   CC      aarch64-softmmu/target/arm/cpu.o
>   CC      aarch64-softmmu/target/arm/neon_helper.o
>   CC      aarch64-softmmu/target/arm/iwmmxt_helper.o
>   CC      aarch64-softmmu/target/arm/gdbstub.o
>   CC      aarch64-softmmu/target/arm/cpu64.o
>   CC      aarch64-softmmu/target/arm/translate-a64.o
>   CC      aarch64-softmmu/target/arm/helper-a64.o
>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>   CC      aarch64-softmmu/target/arm/crypto_helper.o
>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
>   CC      x86_64-softmmu/trace/generated-helpers.o
> /tmp/qemu-test/src/target/arm/translate-a64.c: In function =E2=80=98han=
dle_shri_with_rndacc=E2=80=99:
> /tmp/qemu-test/src/target/arm/translate-a64.c:6369: warning: =E2=80=98t=
cg_src_hi=E2=80=99 may be used uninitialized in this function
> /tmp/qemu-test/src/target/arm/translate-a64.c: In function =E2=80=98dis=
as_simd_scalar_two_reg_misc=E2=80=99:
> /tmp/qemu-test/src/target/arm/translate-a64.c:8096: warning: =E2=80=98r=
mode=E2=80=99 may be used uninitialized in this function
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/trace/control-target.o
> /tmp/qemu-test/src/hw/virtio/virtio.c: In function =E2=80=98virtqueue_m=
ap=E2=80=99:
> /tmp/qemu-test/src/hw/virtio/virtio.c:637: error: too many arguments to=
 function =E2=80=98virtqueue_map_iovec=E2=80=99
>   CC      aarch64-softmmu/gdbstub-xml.o
> make[1]: *** [hw/virtio/virtio.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [subdir-x86_64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/trace/generated-helpers.o
> /tmp/qemu-test/src/hw/virtio/virtio.c: In function =E2=80=98virtqueue_m=
ap=E2=80=99:
> /tmp/qemu-test/src/hw/virtio/virtio.c:637: error: too many arguments to=
 function =E2=80=98virtqueue_map_iovec=E2=80=99
> make[1]: *** [hw/virtio/virtio.o] Error 1
> make: *** [subdir-aarch64-softmmu] Error 2
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-gbyzu407/src'
> make: *** [docker-run-test-quick@centos6] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
