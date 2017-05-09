Received: from eggs.gnu.org ([2001:4830:134:3::10]:37238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1d7x01-0000tN-9r
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1d7wzy-0001QX-8p
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:43:49 -0400
References: <20170508205735.23444-1-ehabkost@redhat.com>
	<20170508205735.23444-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <da425c09-5b05-88a1-f6f3-41aef5850ebc@reactos.org>
Date: Tue, 9 May 2017 06:43:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170508205735.23444-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] audio: Rename audio_init() to
 soundhw_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, Gerd Hoffmann <kraxel@redhat.com>, agraf@suse.de

Le 08/05/2017 =E0 22:57, Eduardo Habkost a =E9crit :
> To make it consistent with the remaining soundhw.c functions and
> avoid confusion with the audio_init() function in audio/audio.c,
> rename audio_init() to soundhw_init().
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

You should probably add a patch before 1/3 to remove the two audio_init()=
/soundhw_init() calls in hw/ppc/prep.c.
That way, you won't need to change hw/ppc/prep.c in 1/3 and 2/3.

Regards,

Herv=E9
> ---
> Changes v2 -> v3:
> * Update hw/ppc/prep.c audio_init() call too
>
> Changes v1 -> v2:
> * Rebase to latest qemu.git master
> ---
>  include/hw/audio/audio.h | 2 +-
>  hw/audio/soundhw.c       | 2 +-
>  hw/ppc/prep.c            | 2 +-
>  vl.c                     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/audio/audio.h b/include/hw/audio/audio.h
> index 259bb2cf96..119f7d78d5 100644
> --- a/include/hw/audio/audio.h
> +++ b/include/hw/audio/audio.h
> @@ -7,7 +7,7 @@ void isa_register_soundhw(const char *name, const char =
*descr,
>  void pci_register_soundhw(const char *name, const char *descr,
>                            int (*init_pci)(PCIBus *bus));
>
> -void audio_init(void);
> +void soundhw_init(void);
>  void select_soundhw(const char *optarg);
>
>  #endif
> diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
> index 5e96b73c81..29565da93d 100644
> --- a/hw/audio/soundhw.c
> +++ b/hw/audio/soundhw.c
> @@ -129,7 +129,7 @@ void select_soundhw(const char *optarg)
>      }
>  }
>
> -void audio_init(void)
> +void soundhw_init(void)
>  {
>      struct soundhw *c;
>      ISABus *isa_bus =3D (ISABus *) object_resolve_path_type("", TYPE_I=
SA_BUS, NULL);
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 96a4813b3f..4a7d2cfbe0 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -783,7 +783,7 @@ static void ibm_40p_init(MachineState *machine)
>                         &cmos_checksum);
>
>      /* initialize audio subsystem */
> -    audio_init();
> +    soundhw_init();
>
>      /* add some more devices */
>      if (defaults_enabled()) {
> diff --git a/vl.c b/vl.c
> index a2400e1ab6..42fd66ac0d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4569,7 +4569,7 @@ int main(int argc, char **argv, char **envp)
>
>      realtime_init();
>
> -    audio_init();
> +    soundhw_init();
>
>      if (hax_enabled()) {
>          hax_sync_vcpus();
>
