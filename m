Received: from eggs.gnu.org ([2001:4830:134:3::10]:40822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpDZJ-0003Ck-Qq
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpDZE-0003T6-Du
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:07:05 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-29-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c04242da-f026-3cc1-7359-a78065a63946@redhat.com>
Date: Tue, 5 Sep 2017 15:06:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-29-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 28/29] libqtest: Remove qtest_start()
 and qtest_end() shortcuts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:Floppy" <qemu-block@nongnu.org>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, armbru@redhat.com, Alexander Graf <agraf@suse.de>, Keith Busch <keith.busch@intel.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 01.09.2017 20:03, Eric Blake wrote:
> Remove the trivial wrappers qtest_start() and qtest_end(), to make
> it obvious in the rest of the testsuite where we are still relying on
> global_qtest.  Doing this makes it easier to see what remaining
> cleanups will be needed if we don't want an implicit dependency
> on global state.  Many tests can also take advantage of qtest_init()
> doing formatting of args, avoiding a temporary local variable.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h               | 26 ------------------
>  tests/libqtest.c               |  4 +--
>  tests/ac97-test.c              |  4 +--
>  tests/boot-order-test.c        | 11 +++-----
>  tests/boot-serial-test.c       | 12 +++------
>  tests/device-introspect-test.c | 24 ++++++++---------
>  tests/display-vga-test.c       | 18 +++++--------
>  tests/drive_del-test.c         | 17 ++++++------
>  tests/ds1338-test.c            |  2 +-
>  tests/e1000-test.c             | 10 ++-----
>  tests/e1000e-test.c            | 14 +++-------
>  tests/eepro100-test.c          | 11 ++------
>  tests/endianness-test.c        | 33 +++++++++--------------
>  tests/es1370-test.c            |  4 +--
>  tests/fdc-test.c               |  4 +--
>  tests/hd-geo-test.c            | 16 +++++------
>  tests/i440fx-test.c            | 16 +++++------
>  tests/i82801b11-test.c         |  5 ++--
>  tests/ide-test.c               |  4 +--
>  tests/intel-hda-test.c         | 11 ++++----
>  tests/ioh3420-test.c           |  7 ++---
>  tests/ipmi-bt-test.c           | 11 +++-----
>  tests/ipmi-kcs-test.c          |  5 +---
>  tests/ipoctal232-test.c        |  5 ++--
>  tests/ivshmem-test.c           |  4 +--
>  tests/libqos/libqos.c          |  2 +-
>  tests/m25p80-test.c            |  9 +++----
>  tests/m48t59-test.c            |  2 +-
>  tests/ne2000-test.c            |  4 +--
>  tests/numa-test.c              | 28 ++++++++++----------
>  tests/nvme-test.c              |  7 ++---
>  tests/pc-cpu-test.c            | 26 +++++++-----------
>  tests/pcnet-test.c             |  4 +--
>  tests/pnv-xscom-test.c         | 14 ++--------
>  tests/prom-env-test.c          | 13 ++++-----
>  tests/pvpanic-test.c           |  4 +--
>  tests/pxe-test.c               | 14 ++++------
>  tests/q35-test.c               |  8 +++---
>  tests/qom-test.c               |  7 ++---
>  tests/rtc-test.c               |  2 +-
>  tests/rtl8139-test.c           |  4 +--
>  tests/spapr-phb-test.c         |  5 ++--
>  tests/tco-test.c               | 12 ++++-----
>  tests/test-arm-mptimer.c       |  4 +--
>  tests/test-filter-mirror.c     | 16 +++++------
>  tests/test-filter-redirector.c | 60 ++++++++++++++++++++----------------------
>  tests/test-hmp.c               |  7 ++---
>  tests/test-netfilter.c         |  9 +++----
>  tests/test-x86-cpuid-compat.c  | 13 ++++-----
>  tests/tmp105-test.c            |  2 +-
>  tests/tpci200-test.c           |  4 +--
>  tests/usb-hcd-ehci-test.c      | 25 +++++++++---------
>  tests/usb-hcd-ohci-test.c      |  4 +--
>  tests/usb-hcd-xhci-test.c      |  4 +--
>  tests/virtio-balloon-test.c    |  4 +--
>  tests/virtio-blk-test.c        | 13 ++++-----
>  tests/virtio-console-test.c    |  8 +++---
>  tests/virtio-net-test.c        |  4 +--
>  tests/virtio-rng-test.c        |  4 +--
>  tests/virtio-serial-test.c     |  4 +--
>  tests/vmgenid-test.c           | 29 ++++++--------------
>  tests/vmxnet3-test.c           |  4 +--
>  62 files changed, 267 insertions(+), 394 deletions(-)
> 
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index d338de3e22..0459526187 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -509,32 +509,6 @@ void qtest_add_data_func_full(const char *str, void *data,
>  void qtest_add_abrt_handler(GHookFunc fn, const void *data);
> 
>  /**
> - * qtest_start:
> - * @args: other arguments to pass to QEMU
> - *
> - * Start QEMU and assign the resulting #QTestState to a global variable.
> - * The global variable is used by "shortcut" functions documented below.
> - *
> - * Returns: #QTestState instance.
> - */
> -static inline QTestState *qtest_start(const char *args)
> -{
> -    global_qtest = qtest_init("%s", args);
> -    return global_qtest;
> -}
> -
> -/**
> - * qtest_end:
> - *
> - * Shut down the QEMU process started by qtest_start().
> - */
> -static inline void qtest_end(void)
> -{
> -    qtest_quit(global_qtest);
> -    global_qtest = NULL;
> -}
> -
> -/**
>   * qmp:
>   * @fmt...: QMP message to send to qemu
>   *
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 18facbf130..fa4e47c137 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -970,7 +970,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
>      QString *qstr;
>      const char *mname;
> 
> -    qtest_start("-machine none");
> +    global_qtest = qtest_init("-machine none");
>      response = qmp("{ 'execute': 'query-machines' }");
>      g_assert(response);
>      list = qdict_get_qlist(response, "return");
> @@ -987,6 +987,6 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
>          cb(mname);
>      }
> 
> -    qtest_end();
> +    qtest_quit(global_qtest);
>      QDECREF(response);
>  }
[...]

Maybe this patch could be postponed 'till we can completely remove
global_qtest? Otherwise you've got to change these lines over and over
again...

 Thomas
