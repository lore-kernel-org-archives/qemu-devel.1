Received: from eggs.gnu.org ([2001:4830:134:3::10]:35816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ePrFi-00013x-4U
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ePrFe-0004gE-VP
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:46:18 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ePrFe-0004fO-LU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:46:14 -0500
Received: by mail-pg0-x243.google.com with SMTP id g7so5935074pgs.0
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 06:46:14 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <04B393D5-2FF3-4694-9BA7-BBD3B8EAB3CB@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_D8429623-1F95-419C-9365-FB24BA33CBE0";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 14 Dec 2017 23:40:49 -0800
In-Reply-To: <20171215033015.738-13-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
	<20171215033015.738-13-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v4 12/43] misc: remove headers implicitly
 included
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>


--Apple-Mail=_D8429623-1F95-419C-9365-FB24BA33CBE0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Dec 14, 2017, at 7:29 PM, Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>=20
> applied using ./scripts/clean-includes
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Ben Warren <ben@skyportsystems.com>

> ---
> hw/audio/fmopl.h             | 1 -
> bsd-user/main.c              | 1 -
> chardev/wctablet.c           | 4 ----
> hw/scsi/vhost-user-scsi.c    | 1 -
> linux-user/main.c            | 1 -
> net/colo-compare.c           | 1 -
> tests/test-aio-multithread.c | 1 -
> tests/test-clone-visitor.c   | 1 -
> tests/vmgenid-test.c         | 3 ---
> 9 files changed, 14 deletions(-)
>=20
> diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
> index f4065f425c..e7e578a48e 100644
> --- a/hw/audio/fmopl.h
> +++ b/hw/audio/fmopl.h
> @@ -1,7 +1,6 @@
> #ifndef FMOPL_H
> #define FMOPL_H
>=20
> -#include <stdint.h>
>=20
> typedef void (*OPL_TIMERHANDLER)(void *param, int channel, double =
interval_Sec);
>=20
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index f1b244b59b..efef5ff8c5 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -32,7 +32,6 @@
> #include "qemu/envlist.h"
> #include "exec/log.h"
> #include "trace/control.h"
> -#include "glib-compat.h"
>=20
> int singlestep;
> unsigned long mmap_min_addr;
> diff --git a/chardev/wctablet.c b/chardev/wctablet.c
> index 6c13c2c58a..969d014574 100644
> --- a/chardev/wctablet.c
> +++ b/chardev/wctablet.c
> @@ -25,10 +25,6 @@
> * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER =
DEALINGS IN
> * THE SOFTWARE.
> */
> -#include <stdlib.h>
> -#include <string.h>
> -#include <sys/time.h>
> -#include <time.h>
>=20
> #include "qemu/osdep.h"
> #include "qemu-common.h"
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index f7561e23fa..9389ed48e0 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -18,7 +18,6 @@
> #include "qemu/osdep.h"
> #include "qapi/error.h"
> #include "qemu/error-report.h"
> -#include "qemu/typedefs.h"
> #include "qom/object.h"
> #include "hw/fw-path-provider.h"
> #include "hw/qdev-core.h"
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 6286661bd3..2fd2a143ed 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -35,7 +35,6 @@
> #include "elf.h"
> #include "exec/log.h"
> #include "trace/control.h"
> -#include "glib-compat.h"
>=20
> char *exec_path;
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 1ce195f877..0ebdec936c 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -23,7 +23,6 @@
> #include "qom/object_interfaces.h"
> #include "qemu/iov.h"
> #include "qom/object.h"
> -#include "qemu/typedefs.h"
> #include "net/queue.h"
> #include "chardev/char-fe.h"
> #include "qemu/sockets.h"
> diff --git a/tests/test-aio-multithread.c =
b/tests/test-aio-multithread.c
> index d396185972..c8bec81520 100644
> --- a/tests/test-aio-multithread.c
> +++ b/tests/test-aio-multithread.c
> @@ -11,7 +11,6 @@
> */
>=20
> #include "qemu/osdep.h"
> -#include <glib.h>
> #include "block/aio.h"
> #include "qapi/error.h"
> #include "qemu/coroutine.h"
> diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
> index 96982163e4..ac6afc562e 100644
> --- a/tests/test-clone-visitor.c
> +++ b/tests/test-clone-visitor.c
> @@ -8,7 +8,6 @@
> */
>=20
> #include "qemu/osdep.h"
> -#include <glib.h>
>=20
> #include "qemu-common.h"
> #include "qapi/clone-visitor.h"
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index 5a86b40775..68ff954578 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -8,9 +8,6 @@
> * See the COPYING file in the top-level directory.
> */
>=20
> -#include <glib.h>
> -#include <string.h>
> -#include <unistd.h>
> #include "qemu/osdep.h"
> #include "qemu/bitmap.h"
> #include "qemu/uuid.h"
> --=20
> 2.15.1
>=20


--Apple-Mail=_D8429623-1F95-419C-9365-FB24BA33CBE0
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILJTCCBTcw
ggQfoAMCAQICED9ye6B5k0+gA4CVDazylRowDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdC
MRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoT
EUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE3MDcxOTAwMDAwMFoXDTE4MDcxOTIzNTk1OVow
JzElMCMGCSqGSIb3DQEJARYWYmVuQHNreXBvcnRzeXN0ZW1zLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAKNRYZm9a+xmI5BPBvGwd5GTtRYq3MeP41a2WqewywtPjLGDhanKK0wI
BghAAqwmQSfs1dukqG1N9fprI5+R+IqOqYle90tdF/P1YdEw6QGYxIfNLJP4Awc3No2LajOw4FcC
zRkkfCTnetztBMX7Jj2mu9+TRDlH/5nlRHZsXLbUgA5jiqha5u4RlgWCrcIdB3f1IBrQeDEaaWqc
XUiTbzqqUgTHEMAmwMf0g587n6tU/l6GhLCzPc49rF1ZD6fQoLN0Mxa/zt81MZrsXgaoz2mzvzn5
ty+9rhGIlKprjnn4vrOzYaU2ieciRLQdAz3B16/nrlVge+EwAe8KCPPIj20CAwEAAaOCAewwggHo
MB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBQCjA79fz82hhynuOG0
ET1twIBPlzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcD
BAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQEC
AQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMFoGA1UdHwRT
MFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRp
Y2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYsGCCsGAQUFBwEBBH8wfTBVBggrBgEFBQcwAoZJ
aHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRT
ZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMCEG
A1UdEQQaMBiBFmJlbkBza3lwb3J0c3lzdGVtcy5jb20wDQYJKoZIhvcNAQELBQADggEBAERxWav/
xDSN35gLVL+7SiNwEUTMMI11WRTwYzP4uhcA5cihdsQDdT8+jljvIcVAQmSd/mLZBjbkYsJa4zpC
fX2D/EtB2D547Fj63efh0vyjLpX4hzhToiLXSXUaLWUhjUQKgGyBpDTpb/2Xbwpg7clWBHy/h4Ax
75RfOdWpaZtQ6g/VxR2mten4dQ8NhtDiv+TlB89LRlQbcGk5A0k/++HlXKwRdTlOXee8+YePAENO
OVUV4C3xuI6eXhxcHuZnBZdVdMTsb5WBsSUTONBTNR5BOUE7xLxcEchP8kHqmqaLSiN7unuUTrug
EYpB7jWGysgKCeKgkEpI9dF++Oqqp70wggXmMIIDzqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0G
CSqGSIb3DQEBDAUAMIGFMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMi
Q09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAx
MDkyMzU5NTlaMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAw
DgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09N
T0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+
nKcxLqf2NHbZhGra0D00SOTq9bus3/mxgUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQ
yDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWW
Co63OTTqRvaq8aWccm+KOMjTcE6s2mj6RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJ
QaDaElmOupyTf1Qib+cpukNJnQmwygjD8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEA
AaOCATwwggE4MB8GA1UdIwQYMBaAFLuvfgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM
+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNV
HSAECjAIMAYGBFUdIAAwTAYDVR0fBEUwQzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20v
Q09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsG
AQUFBzAChi9odHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAk
BggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4
XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkIBtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7Hto
SmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7
I5Px+TbO+88G4zipA2psZaWeEykgzClZlPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4
o50YJafX8mnahjp3I2Y2mkjhk0xQfhNqbzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu
6t99p17bTbY7+1RTWBviN9YJzK8HxzObXYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QI
hhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5ISYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv
9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmUdp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIv
xqith7DoJC91WJ8Lce3CVJqb1XWeKIJ84F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/
vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjGC
A7cwggOzAgEBMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0
Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQP3J7
oHmTT6ADgJUNrPKVGjAJBgUrDgMCGgUAoIIB3zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0xNzEyMTUwNzQwNTBaMCMGCSqGSIb3DQEJBDEWBBR6uKdpsiWT/mhVD3Sn
JlIdRd3+6jCBvQYJKwYBBAGCNxAEMYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGlt
aXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3Vy
ZSBFbWFpbCBDQQIQP3J7oHmTT6ADgJUNrPKVGjCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
GjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBB
dXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhA/cnugeZNPoAOAlQ2s8pUaMA0GCSqG
SIb3DQEBAQUABIIBAIC/ERe6W87w6pg04Z1eRcXKKTxK4t8ByR9+VRBxDNM2QNLGwGk4knW7+MGX
qcdNPsw4kC1vGaE0vqA3kAx7s2exeiZFLYz75hCI9Lmgtd+2FUVPMMEJAelXuu/jYbseGRMywGF+
+vxmwSkva4QA6xTQKVewDzxFzco01/XG1TfEDn3AXEE8QYagznLnMrxPt+4Kb15yc2UPAAn1Qxec
3kQkWT8OWJI8f3rCyfefVdKUP5FnA5Dfp6z7KL92e/m92efmigeibeE//H0XRkuo9Die54CH/kR6
3SYVzS18IdHFdy51oYbs5VOv69wDF6EV5Ja31GBtQZrgy+PwM0F5f5cAAAAAAAA=
--Apple-Mail=_D8429623-1F95-419C-9365-FB24BA33CBE0--
