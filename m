Received: from eggs.gnu.org ([2001:4830:134:3::10]:37605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e1b2e-0006ON-Bc
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e1b2d-0003fz-15
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:36:32 -0400
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-62-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <49ac284f-45c6-0424-753b-895059c50908@redhat.com>
Date: Mon, 9 Oct 2017 12:36:00 -0400
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-62-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 61/88] tests: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-block@nongnu.org



On 10/06/2017 07:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [PMD: split of some files in other commits of the same series, add libq=
test.c]

I think you don't need to add a maintainer's note here unless you
changed something after it was posted to the list.

Acked-by: John Snow <jsnow@redhat.com>

> ---

You can put a V2 notice down here instead.

>  tests/ahci-test.c     | 4 ++--
>  tests/fw_cfg-test.c   | 4 ++--
>  tests/libqos/ahci.c   | 2 +-
>  tests/libqos/libqos.c | 2 +-
>  tests/libqos/malloc.c | 6 +++---
>  tests/libqtest.c      | 2 +-
>  tests/pc-cpu-test.c   | 2 +-
>  7 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/tests/ahci-test.c b/tests/ahci-test.c
> index 999121bb7c..cb84edc8fb 100644
> --- a/tests/ahci-test.c
> +++ b/tests/ahci-test.c
> @@ -155,7 +155,7 @@ static AHCIQState *ahci_vboot(const char *cli, va_l=
ist ap)
>  {
>      AHCIQState *s;
> =20
> -    s =3D g_malloc0(sizeof(AHCIQState));
> +    s =3D g_new0(AHCIQState, 1);
>      s->parent =3D qtest_pc_vboot(cli, ap);
>      alloc_set_flags(s->parent->alloc, ALLOC_LEAK_ASSERT);
> =20
> @@ -1806,7 +1806,7 @@ static void create_ahci_io_test(enum IOMode type,=
 enum AddrMode addr,
>      char *name;
>      AHCIIOTestOptions *opts;
> =20
> -    opts =3D g_malloc(sizeof(AHCIIOTestOptions));
> +    opts =3D g_new(AHCIIOTestOptions, 1);
>      opts->length =3D len;
>      opts->address_type =3D addr;
>      opts->io_type =3D type;
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 688342bed5..81f45bdfc8 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -79,8 +79,8 @@ static void test_fw_cfg_numa(void)
> =20
>      g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), =3D=3D, nb_n=
odes);
> =20
> -    cpu_mask =3D g_malloc0(sizeof(uint64_t) * max_cpus);
> -    node_mask =3D g_malloc0(sizeof(uint64_t) * nb_nodes);
> +    cpu_mask =3D g_new0(uint64_t, max_cpus);
> +    node_mask =3D g_new0(uint64_t, nb_nodes);
> =20
>      qfw_cfg_read_data(fw_cfg, cpu_mask, sizeof(uint64_t) * max_cpus);
>      qfw_cfg_read_data(fw_cfg, node_mask, sizeof(uint64_t) * nb_nodes);
> diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
> index 1ca7f456b5..13c0749582 100644
> --- a/tests/libqos/ahci.c
> +++ b/tests/libqos/ahci.c
> @@ -843,7 +843,7 @@ AHCICommand *ahci_command_create(uint8_t command_na=
me)
>      AHCICommand *cmd;
> =20
>      g_assert(props);
> -    cmd =3D g_malloc0(sizeof(AHCICommand));
> +    cmd =3D g_new0(AHCICommand, 1);
>      g_assert(!(props->dma && props->pio));
>      g_assert(!(props->lba28 && props->lba48));
>      g_assert(!(props->read && props->write));
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index 6226546c28..991bc1aec2 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -17,7 +17,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdlin=
e_fmt, va_list ap)
>  {
>      char *cmdline;
> =20
> -    struct QOSState *qs =3D g_malloc(sizeof(QOSState));
> +    struct QOSState *qs =3D g_new(QOSState, 1);
> =20
>      cmdline =3D g_strdup_vprintf(cmdline_fmt, ap);
>      qs->qts =3D qtest_start(cmdline);
> diff --git a/tests/libqos/malloc.c b/tests/libqos/malloc.c
> index b8eff5f495..ac05874b0a 100644
> --- a/tests/libqos/malloc.c
> +++ b/tests/libqos/malloc.c
> @@ -129,7 +129,7 @@ static MemBlock *mlist_new(uint64_t addr, uint64_t =
size)
>      if (!size) {
>          return NULL;
>      }
> -    block =3D g_malloc0(sizeof(MemBlock));
> +    block =3D g_new0(MemBlock, 1);
> =20
>      block->addr =3D addr;
>      block->size =3D size;
> @@ -305,8 +305,8 @@ QGuestAllocator *alloc_init(uint64_t start, uint64_=
t end)
>      s->start =3D start;
>      s->end =3D end;
> =20
> -    s->used =3D g_malloc(sizeof(MemList));
> -    s->free =3D g_malloc(sizeof(MemList));
> +    s->used =3D g_new(MemList, 1);
> +    s->free =3D g_new(MemList, 1);
>      QTAILQ_INIT(s->used);
>      QTAILQ_INIT(s->free);
> =20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index cbd709470b..adf71188b6 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -171,7 +171,7 @@ QTestState *qtest_init_without_qmp_handshake(const =
char *extra_args)
>      gchar *command;
>      const char *qemu_binary =3D qtest_qemu_binary();
> =20
> -    s =3D g_malloc(sizeof(*s));
> +    s =3D g_new(QTestState, 1);
> =20
>      socket_path =3D g_strdup_printf("/tmp/qtest-%d.sock", getpid());
>      qmp_socket_path =3D g_strdup_printf("/tmp/qtest-%d.qmp", getpid())=
;
> diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
> index c4211a4e85..11d3e810ef 100644
> --- a/tests/pc-cpu-test.c
> +++ b/tests/pc-cpu-test.c
> @@ -87,7 +87,7 @@ static void add_pc_test_case(const char *mname)
>      if (!g_str_has_prefix(mname, "pc-")) {
>          return;
>      }
> -    data =3D g_malloc(sizeof(PCTestData));
> +    data =3D g_new(PCTestData, 1);
>      data->machine =3D g_strdup(mname);
>      data->cpu_model =3D "Haswell"; /* 1.3+ theoretically */
>      data->sockets =3D 1;
>=20
