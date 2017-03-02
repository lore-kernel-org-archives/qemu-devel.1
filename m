Received: from eggs.gnu.org ([2001:4830:134:3::10]:50795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjUhC-0007uq-1n
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjUhB-0002yq-4j
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:39:18 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjUhA-0002yU-Tb
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:39:17 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v186so141657511wmd.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 09:39:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301090453.11075-1-marcandre.lureau@redhat.com>
References: <20170301090453.11075-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 17:38:54 +0000
Message-ID: <CAFEAcA-gpG8VeW1SSpR9f8-au3L3ac9ZtgjbZjxiNcxX_q4C2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/28] Leak patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 March 2017 at 09:04, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om> wrote:
> The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbf=
ba:
>
>   vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)
>
> are available in the git repository at:
>
>   git@github.com:elmarco/qemu.git tags/leak-pull-request
>
> for you to fetch changes up to 80e1eea37a25a7696137e680285e36d0bfdc9f34:
>
>   tests: fix virtio-blk-test leaks (2017-03-01 11:58:57 +0400)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Igor Mammedov (1):
>   pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice
>
> Marc-Andr=C3=A9 Lureau (27):
>   qtest: fix a memory leak
>   tests: fix qmp response leak
>   tests: fix leaks in test-io-channel-command
>   timer: use an inline function for free
>   glib-compat: add g_test_add_data_func_full fallback
>   tests: fix ptimer leaks
>   tests: fix endianness-test leaks
>   tests: fix q35-test leaks
>   tests: fix vhost-user-test leaks
>   tests: fix ide-test leaks
>   tests: fix hd-geo-test leaks
>   tests: fix bios-tables-test leak
>   tests: fix ipmi-kcs-test leak
>   tests: fix ipmi-bt-test leak
>   tests: fix eepro100-test leak
>   tests: fix tco-test leaks
>   tests: fix e1000-test leak
>   tests: fix i440fx-test leaks
>   tests: fix e1000e leaks
>   tests: fix virtio-scsi-test leak
>   tests: fix virtio-9p-test leaks
>   bus: do not unref hotplug handler
>   usb: release the created buses
>   tests: allows to run single test in usb-hcd-ehci-test
>   tests: fix usb-test leaks
>   tests: add specialized device_find function
>   tests: fix virtio-blk-test leaks


Applied, thanks.

-- PMM
