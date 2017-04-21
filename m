Received: from eggs.gnu.org ([2001:4830:134:3::10]:45798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d1aEa-0003l4-69
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d1aEW-0002KJ-S4
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:12:32 -0400
Received: from smtp0.epfl.ch ([2001:620:618:1e0:1:80b2:e058:1]:34834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hossein.ajallooiean@epfl.ch>)
	id 1d1aEW-0002IZ-I6
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:12:28 -0400
From: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>
Date: Fri, 21 Apr 2017 15:12:18 +0000
Message-ID: <1492787538720.44490@epfl.ch>
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
	<1492680594151.52017@epfl.ch>,
	<9d55b0bb-3d76-4b63-52d3-9f7df1003806@ilande.co.uk>
In-Reply-To: <9d55b0bb-3d76-4b63-52d3-9f7df1003806@ilande.co.uk>
Content-Language: en-US
Content-Type: multipart/mixed; boundary="_002_149278753872044490epflch_"
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

--_002_149278753872044490epflch_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for the files and the notes.=0A=
=0A=
I am attaching my config-host file for you. I'm on x86_64, running Linux 64=
, Ubuntu 16.04.2 LTS=0A=
=0A=
so, i can also boot like you do - this worked before as well. btw, if you t=
ry to install that to a disk, itll not be able to as youll need to define m=
emory for it.=0A=
=0A=
The problem is after i install the iso on the qcow2 disk and then try to bo=
ot qemu-system-sparc64.=0A=
=0A=
so here is the steps to reproduce the issue:=0A=
1- create a qcow2 image : debian-9.0-sparc64-NETINST-1.qcow2=0A=
2- download debian image: debian-9.0-sparc64-NETINST-1.iso=0A=
3- install the OS on dIsk=0A=
i use the below command line to do it:=0A=
=0A=
./qemu-system-sparc64 -cdrom /home/nihosa/Downloads/debian-9.0-sparc64-NETI=
NST-1.iso -hda /home/nihosa/Downloads/debian-sparc.qcow2 -nographic -boot d=
 -L pc-bios -m 200=0A=
=0A=
i guess i dont have to define a kernel in the above code???=0A=
=0A=
4- installation goes all well.=0A=
5- i try to run the new disk image: - here i add kernel as if i dont add it=
 ill get the below:=0A=
=0A=
https://pastebin.com/cFwrX9E9=0A=
=0A=
6- so here im adding kernel: - the one that you provided=0A=
./qemu-system-sparc64 -hda <PATH>/debian-sparc.qcow2 -nographic -L pc-bios =
-m 200 -kernel <PATH>/vmlinux=0A=
=0A=
7 -i get a this error now: - with your kernel=0A=
https://pastebin.com/Z0ah7nji=0A=
=0A=
8- if i use the newest kernel: available/stable i get this error: - i am co=
mpiling the kernel myself=0A=
https://pastebin.com/6EDYiaxX=0A=
=0A=
=0A=
9- and if i use a kernel that was working with 2.7 - i get this:=0A=
https://pastebin.com/bWbsrKCm=0A=
=0A=
=0A=
Thanks=0A=
Hoss=0A=
________________________________________=0A=
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>=0A=
Sent: Friday, April 21, 2017 2:03 PM=0A=
To: Ajallooiean Hossein; qemu-devel@nongnu.org=0A=
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic=0A=
=0A=
On 20/04/17 10:29, Ajallooiean Hossein wrote:=0A=
=0A=
> Thanks for getting back to me so quickly.=0A=
>=0A=
> I can boot Sparc64  -- ONLY when using the qemu from package manager. sup=
posedly version 2.5=0A=
>=0A=
> but when building it myself (as i have some additions) - im getting this =
kernel error:=0A=
>=0A=
> https://pastebin.com/9XjdrUat=0A=
>=0A=
>=0A=
> I am compiling qemu by myself and am using the following cmd to run it:=
=0A=
>=0A=
>=0A=
> /Downloads/qemu-2.9.0-rc4/sparc64-softmmu$ ./qemu-system-sparc64 -M sun4u=
 -m 196 -kernel /home/nihosa/Downloads/kernel4.10.11.sparc64 -hda /home/nih=
osa/Downloads/debian-9.0-sparc64-NETINST-1.qcow2 -nographic -L pc-bios=0A=
>=0A=
>=0A=
> If you have it running, could you please send me your kernel/image for te=
sting?=0A=
=0A=
I've just uploaded my latest kernel build and .config here for you to test:=
=0A=
=0A=
https://www.ilande.co.uk/tmp/qemu/sparc64-kernel/vmlinux=0A=
https://www.ilande.co.uk/tmp/qemu/sparc64-kernel/.config=0A=
=0A=
Can you also confirm your host architecture and the compiler/version you=0A=
are using?=0A=
=0A=
=0A=
ATB,=0A=
=0A=
Mark.=0A=
=0A=

--_002_149278753872044490epflch_
Content-Type: text/x-makefile; name="config-host.mak"
Content-Description: config-host.mak
Content-Disposition: attachment; filename="config-host.mak"; size=3991;
	creation-date="Fri, 21 Apr 2017 14:54:35 GMT";
	modification-date="Fri, 21 Apr 2017 14:54:35 GMT"
Content-Transfer-Encoding: base64

IyBBdXRvbWF0aWNhbGx5IGdlbmVyYXRlZCBieSBjb25maWd1cmUgLSBkbyBub3QgbW9kaWZ5Cgph
bGw6CnByZWZpeD0vdXNyL2xvY2FsCmJpbmRpcj0ke3ByZWZpeH0vYmluCmxpYmRpcj0ke3ByZWZp
eH0vbGliCmxpYmV4ZWNkaXI9JHtwcmVmaXh9L2xpYmV4ZWMKaW5jbHVkZWRpcj0ke3ByZWZpeH0v
aW5jbHVkZQptYW5kaXI9JHtwcmVmaXh9L3NoYXJlL21hbgpzeXNjb25mZGlyPSR7cHJlZml4fS9l
dGMKcWVtdV9jb25mZGlyPSR7cHJlZml4fS9ldGMvcWVtdQpxZW11X2RhdGFkaXI9JHtwcmVmaXh9
L3NoYXJlL3FlbXUKcWVtdV9kb2NkaXI9JHtwcmVmaXh9L3NoYXJlL2RvYy9xZW11CnFlbXVfbW9k
ZGlyPSR7cHJlZml4fS9saWIvcWVtdQpxZW11X2xvY2Fsc3RhdGVkaXI9JHtwcmVmaXh9L3Zhcgpx
ZW11X2hlbHBlcmRpcj0ke3ByZWZpeH0vbGliZXhlYwpleHRyYV9jZmxhZ3M9LW02NCAtbWN4MTYg
CmV4dHJhX2xkZmxhZ3M9CnFlbXVfbG9jYWxlZGlyPSR7cHJlZml4fS9zaGFyZS9sb2NhbGUKbGli
c19zb2Z0bW11PS1scGl4bWFuLTEgLWx1dGlsICAgLUwkKEJVSUxEX0RJUikvZHRjL2xpYmZkdCAt
bGZkdApBUkNIPXg4Nl82NApTVFJJUD1zdHJpcApDT05GSUdfUE9TSVg9eQpDT05GSUdfTElOVVg9
eQpDT05GSUdfU0xJUlA9eQpDT05GSUdfU01CRF9DT01NQU5EPSIvdXNyL3NiaW4vc21iZCIKQ09O
RklHX0wyVFBWMz15CkNPTkZJR19BVURJT19EUklWRVJTPW9zcwpDT05GSUdfT1NTPXkKQ09ORklH
X0JEUlZfUldfV0hJVEVMSVNUPQpDT05GSUdfQkRSVl9ST19XSElURUxJU1Q9CkNPTkZJR19WTkM9
eQpDT05GSUdfRk5NQVRDSD15ClZFUlNJT049Mi44Ljk0ClBLR1ZFUlNJT049ClNSQ19QQVRIPS9o
b21lL25paG9zYS9Eb3dubG9hZHMvcWVtdS0yLjkuMC1yYzQKVEFSR0VUX0RJUlM9c3BhcmM2NC1z
b2Z0bW11CkNPTkZJR19VVElNRU5TQVQ9eQpDT05GSUdfUElQRTI9eQpDT05GSUdfQUNDRVBUND15
CkNPTkZJR19TUExJQ0U9eQpDT05GSUdfRVZFTlRGRD15CkNPTkZJR19GQUxMT0NBVEU9eQpDT05G
SUdfRkFMTE9DQVRFX1BVTkNIX0hPTEU9eQpDT05GSUdfRkFMTE9DQVRFX1pFUk9fUkFOR0U9eQpD
T05GSUdfUE9TSVhfRkFMTE9DQVRFPXkKQ09ORklHX1NZTkNfRklMRV9SQU5HRT15CkNPTkZJR19G
SUVNQVA9eQpDT05GSUdfRFVQMz15CkNPTkZJR19QUE9MTD15CkNPTkZJR19QUkNUTF9QUl9TRVRf
VElNRVJTTEFDSz15CkNPTkZJR19FUE9MTD15CkNPTkZJR19FUE9MTF9DUkVBVEUxPXkKQ09ORklH
X1NFTkRGSUxFPXkKQ09ORklHX1RJTUVSRkQ9eQpDT05GSUdfU0VUTlM9eQpDT05GSUdfQ0xPQ0tf
QURKVElNRT15CkNPTkZJR19TWU5DRlM9eQpDT05GSUdfSU5PVElGWT15CkNPTkZJR19JTk9USUZZ
MT15CkNPTkZJR19CWVRFU1dBUF9IPXkKQ09ORklHX0hBU19HTElCX1NVQlBST0NFU1NfVEVTVFM9
eQpDT05GSUdfVExTX1BSSU9SSVRZPSJOT1JNQUwiCkhBVkVfSUZBRERSU19IPXkKQ09ORklHX0FU
VFI9eQpDT05GSUdfVkhPU1RfU0NTST15CkNPTkZJR19WSE9TVF9ORVRfVVNFRD15CkNPTkZJR19W
SE9TVF9WU09DSz15CklOU1RBTExfQkxPQlM9eWVzCkNPTkZJR19JT1ZFQz15CkNPTkZJR19QUkVB
RFY9eQpDT05GSUdfRkRUPXkKQ09ORklHX1NJR05BTEZEPXkKQ09ORklHX0ZEQVRBU1lOQz15CkNP
TkZJR19NQURWSVNFPXkKQ09ORklHX1BPU0lYX01BRFZJU0U9eQpDT05GSUdfQVZYMl9PUFQ9eQpD
T05GSUdfQlpJUDI9eQpCWklQMl9MSUJTPS1sYnoyCkNPTkZJR19RT01fQ0FTVF9ERUJVRz15CkNP
TkZJR19DT1JPVVRJTkVfQkFDS0VORD11Y29udGV4dApDT05GSUdfQ09ST1VUSU5FX1BPT0w9MQpD
T05GSUdfT1BFTl9CWV9IQU5ETEU9eQpDT05GSUdfTElOVVhfTUFHSUNfSD15CkNPTkZJR19QUkFH
TUFfRElBR05PU1RJQ19BVkFJTEFCTEU9eQpDT05GSUdfVkFMR1JJTkRfSD15CkNPTkZJR19IQVNf
RU5WSVJPTj15CkNPTkZJR19DUFVJRF9IPXkKQ09ORklHX0lOVDEyOD15CkNPTkZJR19BVE9NSUMx
Mjg9eQpDT05GSUdfQVRPTUlDNjQ9eQpDT05GSUdfR0VUQVVYVkFMPXkKSE9TVF9VU0I9c3R1YgpD
T05GSUdfVFBNPSQoQ09ORklHX1NPRlRNTVUpCkNPTkZJR19UUE1fUEFTU1RIUk9VR0g9eQpUUkFD
RV9CQUNLRU5EUz1sb2cKQ09ORklHX1RSQUNFX0xPRz15CkNPTkZJR19UUkFDRV9GSUxFPXRyYWNl
CkNPTkZJR19SVE5FVExJTks9eQpDT05GSUdfUkVQTElDQVRJT049eQpDT05GSUdfQUZfVlNPQ0s9
eQpDT05GSUdfU1lTTUFDUk9TPXkKQ09ORklHX1RIUkVBRF9TRVROQU1FX0JZVEhSRUFEPXkKQ09O
RklHX1BUSFJFQURfU0VUTkFNRV9OUD15ClRPT0xTPXFlbXUtZ2EgaXZzaG1lbS1jbGllbnQkKEVY
RVNVRikgaXZzaG1lbS1zZXJ2ZXIkKEVYRVNVRikgcWVtdS1uYmQkKEVYRVNVRikgcWVtdS1pbWck
KEVYRVNVRikgcWVtdS1pbyQoRVhFU1VGKSAKUk9NUz1vcHRpb25yb20KTUFLRT1tYWtlCklOU1RB
TEw9aW5zdGFsbApJTlNUQUxMX0RJUj1pbnN0YWxsIC1kIC1tIDA3NTUKSU5TVEFMTF9EQVRBPWlu
c3RhbGwgLWMgLW0gMDY0NApJTlNUQUxMX1BST0c9aW5zdGFsbCAtYyAtbSAwNzU1CklOU1RBTExf
TElCPWluc3RhbGwgLWMgLW0gMDY0NApQWVRIT049cHl0aG9uIC1CCkNDPWNjCkNDX0kzODY9JChD
QykgLW0zMgpIT1NUX0NDPWNjCkNYWD1jKysKT0JKQ0M9Y2MKQVI9YXIKQVJGTEFHUz1ydgpBUz1h
cwpDQ0FTPWNjCkNQUD1jYyAtRQpPQkpDT1BZPW9iamNvcHkKTEQ9bGQKTk09bm0KV0lORFJFUz13
aW5kcmVzCkNGTEFHUz0tTzIgLVVfRk9SVElGWV9TT1VSQ0UgLURfRk9SVElGWV9TT1VSQ0U9MiAt
ZyAKQ0ZMQUdTX05PUElFPQpRRU1VX0NGTEFHUz0tSS91c3IvaW5jbHVkZS9waXhtYW4tMSAtSSQo
U1JDX1BBVEgpL2R0Yy9saWJmZHQgLXB0aHJlYWQgLUkvdXNyL2luY2x1ZGUvZ2xpYi0yLjAgLUkv
dXNyL2xpYi94ODZfNjQtbGludXgtZ251L2dsaWItMi4wL2luY2x1ZGUgLWZQSUUgLURQSUUgLW02
NCAtbWN4MTYgLURfR05VX1NPVVJDRSAtRF9GSUxFX09GRlNFVF9CSVRTPTY0IC1EX0xBUkdFRklM
RV9TT1VSQ0UgLVdzdHJpY3QtcHJvdG90eXBlcyAtV3JlZHVuZGFudC1kZWNscyAtV2FsbCAtV3Vu
ZGVmIC1Xd3JpdGUtc3RyaW5ncyAtV21pc3NpbmctcHJvdG90eXBlcyAtZm5vLXN0cmljdC1hbGlh
c2luZyAtZm5vLWNvbW1vbiAtZndyYXB2ICAtV2VuZGlmLWxhYmVscyAtV25vLW1pc3NpbmctaW5j
bHVkZS1kaXJzIC1XZW1wdHktYm9keSAtV25lc3RlZC1leHRlcm5zIC1XZm9ybWF0LXNlY3VyaXR5
IC1XZm9ybWF0LXkyayAtV2luaXQtc2VsZiAtV2lnbm9yZWQtcXVhbGlmaWVycyAtV29sZC1zdHls
ZS1kZWNsYXJhdGlvbiAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1XdHlwZS1saW1pdHMgLWZzdGFj
ay1wcm90ZWN0b3Itc3Ryb25nClFFTVVfSU5DTFVERVM9LUkkKFNSQ19QQVRIKS90Y2cgLUkkKFNS
Q19QQVRIKS90Y2cvaTM4NiAtSSQoU1JDX1BBVEgpL2xpbnV4LWhlYWRlcnMgLUkvaG9tZS9uaWhv
c2EvRG93bmxvYWRzL3FlbXUtMi45LjAtcmM0L2xpbnV4LWhlYWRlcnMgLUkuIC1JJChTUkNfUEFU
SCkgLUkkKFNSQ19QQVRIKS9pbmNsdWRlCkFVVE9DT05GX0hPU1QgOj0gCkxERkxBR1M9LVdsLC0t
d2Fybi1jb21tb24gLVdsLC16LHJlbHJvIC1XbCwteixub3cgLXBpZSAtbTY0IC1nIApMREZMQUdT
X05PUElFPQpMRF9SRUxfRkxBR1M9LVdsLC1yIC1XbCwtLW5vLXJlbGF4CkxEX0kzODZfRU1VTEFU
SU9OPWVsZl9pMzg2CkxJQlMrPS1sbSAtbGd0aHJlYWQtMi4wIC1wdGhyZWFkIC1sZ2xpYi0yLjAg
IC1seiAtbHJ0CkxJQlNfVE9PTFMrPQpQVEhSRUFEX0xJQj0KRVhFU1VGPQpEU09TVUY9LnNvCkxE
RkxBR1NfU0hBUkVEPS1zaGFyZWQKTElCU19RR0ErPS1sbSAtbGd0aHJlYWQtMi4wIC1wdGhyZWFk
IC1sZ2xpYi0yLjAgIC1scnQKVEFTTjFfTElCUz0KVEFTTjFfQ0ZMQUdTPQpQT0QyTUFOPXBvZDJt
YW4gLS11dGY4ClRSQU5TTEFURV9PUFRfQ0ZMQUdTPQpjb25maWctaG9zdC5oOiBzdWJkaXItZHRj
Cg==

--_002_149278753872044490epflch_--
