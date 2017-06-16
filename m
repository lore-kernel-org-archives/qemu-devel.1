Received: from eggs.gnu.org ([2001:4830:134:3::10]:45085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLr1K-0000EZ-Pq
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLr1H-0000A7-Ks
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:10:38 -0400
Received: from chuckie.co.uk ([82.165.15.123]:53112
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dLr1H-00008G-Df
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:10:35 -0400
References: <149761549922.8532.9477919693762967896@4a9a010726c0>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ab09a773-986f-fac1-6757-0cac037eb0e9@ilande.co.uk>
Date: Fri, 16 Jun 2017 14:10:20 +0100
MIME-Version: 1.0
In-Reply-To: <149761549922.8532.9477919693762967896@4a9a010726c0>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 0/5] fw_cfg: qdev-related tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, famz@redhat.com, ehabkost@redhat.com, mst@redhat.com, somlo@cmu.edu, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 16/06/17 13:18, no-reply@patchew.org wrote:

> In file included from /tmp/qemu-test/src/include/hw/loader.h:5,
>                  from /tmp/qemu-test/src/device_tree.c:27:
> /tmp/qemu-test/src/include/hw/nvram/fw_cfg.h:75: error: redefinition of typedef ‘FWCfgState’
> /tmp/qemu-test/src/include/qemu/typedefs.h:35: note: previous declaration of ‘FWCfgState’ was here
> /tmp/qemu-test/src/include/hw/nvram/fw_cfg.h:84: error: redefinition of typedef ‘FWCfgIoState’
> /tmp/qemu-test/src/include/qemu/typedefs.h:33: note: previous declaration of ‘FWCfgIoState’ was here
> /tmp/qemu-test/src/include/hw/nvram/fw_cfg.h:94: error: redefinition of typedef ‘FWCfgMemState’
> /tmp/qemu-test/src/include/qemu/typedefs.h:34: note: previous declaration of ‘FWCfgMemState’ was here
> make: *** [device_tree.o] Error 1
> make: *** Waiting for unfinished jobs....
> In file included from /tmp/qemu-test/src/include/hw/loader.h:5,
>                  from /tmp/qemu-test/src/vl.c:73:
> /tmp/qemu-test/src/include/hw/nvram/fw_cfg.h:75: error: redefinition of typedef ‘FWCfgState’
> /tmp/qemu-test/src/include/qemu/typedefs.h:35: note: previous declaration of ‘FWCfgState’ was here
> /tmp/qemu-test/src/include/hw/nvram/fw_cfg.h:84: error: redefinition of typedef ‘FWCfgIoState’
> /tmp/qemu-test/src/include/qemu/typedefs.h:33: note: previous declaration of ‘FWCfgIoState’ was here
> /tmp/qemu-test/src/include/hw/nvram/fw_cfg.h:94: error: redefinition of typedef ‘FWCfgMemState’
> /tmp/qemu-test/src/include/qemu/typedefs.h:34: note: previous declaration of ‘FWCfgMemState’ was here
> make: *** [vl.o] Error 1
> tests/docker/Makefile.include:118: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-mjmbvk4m/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-quick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2
> === OUTPUT END ===

During the rework I accidentally picked up a change from an experimental
branch which (among other changes) added typedefs to the FWCfg*State
structs which I though were needed, but really aren't because they are
already defined in typedefs.h.

Revised version to follow shortly.


ATB,

Mark.
