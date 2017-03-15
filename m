Received: from eggs.gnu.org ([2001:4830:134:3::10]:57289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1coC5G-00017G-KV
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1coC5F-000266-ML
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:47:34 -0400
Date: Wed, 15 Mar 2017 18:47:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170315164724.37z6yeapl3wujgh4@kozik-lap>
References: <20170313180432.7067-1-krzk@kernel.org> <87mvcnpzll.fsf@linaro.org>
	<20170314173513.wruppu4js7ikaxu2@kozik-lap>
	<CAHDbmO1apk81csbC7BJK2JFK23fvVBLb-wA5z7_y29T=ueFPyg@mail.gmail.com>
	<20170314185632.kzbccv2y7ah3nhqd@kozik-lap>
	<87k27rotgb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87k27rotgb.fsf@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 0/5] hw: arm: exynos: Bring
 up secondary CPU + CPUIDLE issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Wed, Mar 15, 2017 at 08:05:56AM +0000, Alex Benn=C3=A9e wrote:
>=20
> Krzysztof Kozlowski <krzk@kernel.org> writes:
>=20
> > On Tue, Mar 14, 2017 at 06:24:33PM +0000, Alex Benn=C3=A9e wrote:
> >> That means you're on a pre-mttcg tree so that's not the reason.
> >
> > I managed to build it on current master (v2.8.0-2182-g5e2fb7c598c6). It
> > behaves the same (with "-accel tcg,thread=3Dsingle": cannot reach
> > switching to init).
>=20
> Interesting. Can you post your exact qemu command line and I'll have a
> go at reproducing.

I build usually with:
=2E./qemu/configure --cc=3D"ccache cc" --cxx=3D"ccache c++" --enable-debug =
--enable-fdt \
	--enable-kvm --enable-libusb --enable-libssh2 --enable-lzo \
	--enable-bzip2 --enable-curses --enable-gtk  --enable-cap-ng

Running with command:
arm-softmmu/qemu-system-arm -m 1024 -M smdkc210 -smp 2 -append \
	'console=3DttySAC0,115200n8 console=3DttyS0 earlyprintk' -d guest_errors \
	-serial stdio -D ..//log-smdkc210.log -kernel ../cur-linux/zImage
	-dtb ../cur-linux/dts/exynos4210-smdkv310.dtb
	-initrd ../armv7-odroidu3-exynos-v4.10-initramfs.cpio.gz

Plus the -accel line, depending on the needs.

The initramfs is a simple one from Arch Arm.

>=20
> In the meantime you can always --enable-debug-tcg your build and see if
> any of the asserts fire.

enable-debug-tcg did not change much - no asserts. The last dmesg is:
[   72.616013] Registering SWP/SWPB emulation handler
[   74.484873] s3c64xx-spi 13940000.spi: spi bus clock parent not specified=
, using clock at index 0 as parent
[   74.485994] s3c64xx-spi 13940000.spi: number of chip select lines not sp=
ecified, assuming 1 chip select line
[   74.493249] s3c64xx-spi 13940000.spi: Failed to get RX DMA channel
[   74.503885] hctosys: unable to open rtc device (rtc0)
[   74.523004] ALSA device list:
[   74.523711]   No soundcards found.
[   74.542278] samsung-uart 13800000.serial: DMA request failed, DMA will n=
ot be used


Best regards,
Krzysztof
