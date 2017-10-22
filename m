Received: from eggs.gnu.org ([2001:4830:134:3::10]:41755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dualbus@gmail.com>) id 1e6IsO-0008Pd-Pl
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 12:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dualbus@gmail.com>) id 1e6IsL-0005CJ-DA
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 12:13:24 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:51910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dualbus@gmail.com>) id 1e6IsL-0005Bc-4p
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 12:13:21 -0400
Received: by mail-pg0-x22c.google.com with SMTP id p9so9988986pgc.8
	for <qemu-devel@nongnu.org>; Sun, 22 Oct 2017 09:13:19 -0700 (PDT)
Received: from localhost ([201.157.162.185]) by smtp.gmail.com with ESMTPSA id
	r22sm8963624pfl.15.2017.10.22.09.13.14 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 22 Oct 2017 09:13:15 -0700 (PDT)
Date: Sun, 22 Oct 2017 11:13:12 -0500
From: Eduardo =?iso-8859-1?Q?A=2E_Bustamante_L=F3pez?= <dualbus@gmail.com>
Message-ID: <20171022161312.4xlitnw2bknvv7ml@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nbk3g2gnsvwil2md"
Content-Disposition: inline
Subject: [Qemu-devel] Unable to clone git repository from git.qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


--nbk3g2gnsvwil2md
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(please keep me CC'ed, I'm not subscribed)

Hi,

I apologize if this is not the right mailing list for this report. I'm unab=
le to clone the git repository from
git://git.qemu.org/qemu.git (which is listed on https://www.qemu.org/contri=
bute/).

I'm getting TCP RST's when I try to clone it, as indicated by the packet ca=
pture:

  dualbus@ubuntu:~/src/qemu$ git clone git://git.qemu.org/qemu.git
  Cloning into 'qemu'...
  fatal: read error: Connection reset by peer

  dualbus@ubuntu:~/src/qemu$ git clone git://git.qemu.org/qemu.git
  Cloning into 'qemu'...
  fatal: Could not read from remote repository.
 =20
  Please make sure you have the correct access rights
  and the repository exists.

  ---

  dualbus@ubuntu:~$ sudo tcpdump -n 'host git.qemu.org'
  tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
  listening on eno1, link-type EN10MB (Ethernet), capture size 262144 bytes
  10:29:34.459497 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [S], s=
eq 1870728944, win 29200, options [mss 1460,sackOK,TS val 500213983 ecr 0,n=
op,wscale 7], length 0
  10:29:35.487129 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [S], s=
eq 1870728944, win 29200, options [mss 1460,sackOK,TS val 500214240 ecr 0,n=
op,wscale 7], length 0
  10:29:35.487854 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [S.], =
seq 1436706601, ack 1870728945, win 28960, options [mss 1380,sackOK,TS val =
3511630652 ecr 500213983,nop,wscale 10], length 0
  10:29:35.487949 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [.], a=
ck 1, win 229, options [nop,nop,TS val 500214240 ecr 3511630652], length 0
  10:29:35.488077 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [P.], =
seq 1:49, ack 1, win 229, options [nop,nop,TS val 500214240 ecr 3511630652]=
, length 48
  10:29:36.604320 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [S.], =
seq 1436706601, ack 1870728945, win 28960, options [mss 1380,sackOK,TS val =
3511631678 ecr 500213983,nop,wscale 10], length 0
  10:29:36.604378 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [.], a=
ck 1, win 229, options [nop,nop,TS val 500214519 ecr 3511630652], length 0
  10:29:36.608418 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [.], a=
ck 49, win 29, options [nop,nop,TS val 3511631682 ecr 500214240], length 0
  10:29:36.608943 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [R.], =
seq 1, ack 49, win 29, options [nop,nop,TS val 0 ecr 500214240], length 0
  10:29:37.553793 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [R.], =
seq 1, ack 49, win 229, length 0
  10:29:40.037068 IP 192.168.1.108.43170 > 172.99.69.163.9418: Flags [S], s=
eq 4085609936, win 29200, options [mss 1460,sackOK,TS val 500215377 ecr 0,n=
op,wscale 7], length 0
  10:29:41.038109 IP 172.99.69.163.9418 > 192.168.1.108.43170: Flags [S.], =
seq 1040747289, ack 4085609937, win 28960, options [mss 1380,sackOK,TS val =
3511636236 ecr 500215377,nop,wscale 10], length 0
  10:29:41.038218 IP 192.168.1.108.43170 > 172.99.69.163.9418: Flags [.], a=
ck 1, win 229, options [nop,nop,TS val 500215627 ecr 3511636236], length 0
  10:29:41.038398 IP 192.168.1.108.43170 > 172.99.69.163.9418: Flags [P.], =
seq 1:49, ack 1, win 229, options [nop,nop,TS val 500215627 ecr 3511636236]=
, length 48
  10:29:42.111622 IP 172.99.69.163.9418 > 192.168.1.108.43170: Flags [F.], =
seq 1, ack 1, win 29, options [nop,nop,TS val 3511637236 ecr 500215627], le=
ngth 0
  10:29:42.113384 IP 192.168.1.108.43170 > 172.99.69.163.9418: Flags [F.], =
seq 49, ack 2, win 229, options [nop,nop,TS val 500215896 ecr 3511637236], =
length 0
  10:29:42.121555 IP 172.99.69.163.9418 > 192.168.1.108.43170: Flags [R], s=
eq 1040747290, win 0, length 0
  10:29:43.121773 IP 172.99.69.163.9418 > 192.168.1.108.43170: Flags [R.], =
seq 2, ack 50, win 229, length 0
  ^C
  18 packets captured
  27 packets received by filter
  0 packets dropped by kernel


I was able to clone it via HTTPS, but now I'm having issues updating the gi=
t submodules

  dualbus@ubuntu:~/src/qemu/qemu$ git submodule update ui/keycodemapdb
  Cloning into '/home/dualbus/src/qemu/qemu/ui/keycodemapdb'...
  fatal: Could not read from remote repository.
 =20
  Please make sure you have the correct access rights
  and the repository exists.
  fatal: clone of 'git://git.qemu.org/keycodemapdb.git' into submodule path=
 '/home/dualbus/src/qemu/qemu/ui/keycodemapdb'
  failed
  Failed to clone 'ui/keycodemapdb'. Retry scheduled
  Cloning into '/home/dualbus/src/qemu/qemu/ui/keycodemapdb'...
  fatal: Could not read from remote repository.
 =20
  Please make sure you have the correct access rights
  and the repository exists.
  fatal: clone of 'git://git.qemu.org/keycodemapdb.git' into submodule path=
 '/home/dualbus/src/qemu/qemu/ui/keycodemapdb'
  failed
  Failed to clone 'ui/keycodemapdb' a second time, aborting

--nbk3g2gnsvwil2md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJZ7MOXAAoJEPTLFBpAe6TPYxkH/3vo2KlGspZmcCH33GJebbHb
00DWttgSy6bU45SI2vHOR8eeLwqF4KJmkjZ54XrJbZATVHE1uZfCjxw5KsFxJyny
A7Ln4QHhEkR9MtKj82xp57MiykoCzHkhkN/0/UXOOZVxzuW4Oaa0Abdh3kJJ+HOp
rkB4dj0g00ytlqwTiAA9AbplugL4HjW+NeDIusdMonnHvDykGuVIEhIy8bvP8wiC
7h6M/wAIqFRaPo7BwV4QmTejNU2G2f7enwzfms9pU6DPFJ/NJHsLZ1609dR24xsv
bduzY481GdGKi8iRE4tzHPVh3LQyAMRc0/DkJVHqeYypzGLsXmQsgG1FkMZzai4=
=TIsk
-----END PGP SIGNATURE-----

--nbk3g2gnsvwil2md--
