Received: from eggs.gnu.org ([2001:4830:134:3::10]:44400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9Q3n-0000oW-HG
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9Q3m-0006cS-Mx
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:34:35 -0400
Received: from mail-it1-x132.google.com ([2607:f8b0:4864:20::132]:40527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g9Q3m-0006cB-FH
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:34:34 -0400
Received: by mail-it1-x132.google.com with SMTP id i191-v6so10583635iti.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 00:34:34 -0700 (PDT)
MIME-Version: 1.0
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 8 Oct 2018 15:33:56 +0800
Message-ID: <CAKXe6SJVhc6Nyz+kUVk5NK9nfN=PN2pTB-bZyOeVY2SP+POtqw@mail.gmail.com>
Content-Type: multipart/related; boundary="000000000000041fd30577b2a7b2"
Subject: [Qemu-devel] Strange behavior abount bootindex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, arei.gonglei@huawei.com, Gerd Hoffmann <kraxel@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>

--000000000000041fd30577b2a7b2
Content-Type: text/plain; charset="UTF-8"

Hello Paolo, Lei, Gerd and all,


Recently I encounter a strange issue about bootindex.

I have two disk named "disk1.test" and "disk1".

When using disk1.test alone, the login picture is: (hostname is localhost)

[image: image.png]

When using disk1 alone, the login picture is:(hostname is nimlite-test)

[image: image.png]

However, when I launch a VM with two virtio-blck-pci device:
disk1.test, bootindex=1
disk1, bootindex=2

I see the above picture alternately. Sometimes the hostname is "localhost",
sometimes the hostname is "nimlite-test". Seems the bootindex has no effect.

I have see the qemu and seabios code, seems no obvious bug. There is no
'handle_18' called in seabios.

The disk1 is originated from disk1.test(CentOS). and when I repalce with
disk.test with a
Debian image, there seems no issue.

So I think there maybe a bug in qemu block layer or guest os?

Could anyone give some hints?

Thanks,
Li Qiang

The command I used is below:

qemu-devel/qemu/x86_64-softmmu/qemu-system-x86_64 -m 1024 -smp 2 -drive
file=disk1.test,format=raw,if=none,id=id1,cache=none -device
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=id1,id=virtio1,bootindex=1
-vnc :100 --enable-kvm -drive
file=disk1,format=raw,if=none,id=id2,cache=none -device
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x7,drive=id2,bootindex=2 -boot
strict=on  -boot menu=on  -debugcon file:/home/liqiang02/qemu-devel/4.txt
-global isa-debugcon.iobase=0x402 -bios qemu-devel/seabios/out/bios.bin

--000000000000041fd30577b2a7b2
Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_jmzy4jfq0>
X-Attachment-Id: ii_jmzy4jfq0

iVBORw0KGgoAAAANSUhEUgAAAYkAAABUCAYAAAB3Csv4AAAM4klEQVR4Ae2dy24kSRWGs1K1YXYs
hj3zLqwQSFymNXRPX9w9G5azACHWvABCSKxg3/ASwCMgARJbNqNpzUBf7XK7Ep2yf3N8HHmLqqjK
LH8tWRFxLv858YUrs11lVy3++s8Xzbc//Eb1+c9+Wf3x97+u+AcBCEAAAhAQgVoTRghAAAIQgEAk
wE0iEmENAQhAAALXBLhJXKNgAgEIQAACkQA3iUiENQQgAAEIXBPgJnGNggkEIAABCEQC3CQiEdYQ
gAAEIHBNgJvENQomEIAABCAQCSyjwdbPnz+/Yb53796N9S4WViOlG2tbLR/X5+/qLeZ63Zin2K6Y
mFN6rZ5SdXL6lF7MlV11ol/2UqPq77tuqf2gC4E5E7j1k4R/gOpBKtuuNtqmJ7vV1ZfVlF2jfGP7
U7xp+vmu9rUvnbj/nLqepc/3djGSzceVnB+qbsk9oQ2BuRK4cZPQxUAPUtuUn891kzl9276ntvdd
9ZQ6Z2OUsh+Kgeqqp5wzJAcCENiewLJqml4VPWAtMPWglV8+W2tuOdGvgoqRX/a2UbqWpxyNbTk5
dvVluV5fdvUhbcV4v/n61sqPcbJPZdT+/J58b/L7fWhucfL35XtN5hCAwDQI3PhJoq8lPfDtQa8v
y/F2rdv8/oLhY/pqy698q6m68u1qVI2oJ7vV9b0P7cPnS1u58sk+ZNwmd4h+jPH1UvvXHnycaWit
UbkxPtZjDQEIHJ7A5QvX/T9M3OhUD/Ybxj0u/MXFetF6jy1kl7JerWfPMKd/5efkZjc/IrGrL/U+
Qo5QCEDgQASWI+8Pmza7LgD73If1oQvuVHoasn/1bbE5fesim5M7pL9dxqR6TNl2WRMtCEBgdwQG
Pd2ki9LuyuYp6YaQl92ete/9+Xp+3t7hYT1z6PGwhKgOgeMlcOMmof/h+YuCn6cwmL8vJpUn27b5
0skdt+k9p6bqGesU7xzNsTltdVN29Tu2xtD4tvNXXfU0VI84CEBgtwQWf/nHl81HH35Qff7z/3/o
kB6gKuUfqNFnMSm/bIrXWpqyt+Urbqzf58W5rxl9vr8Yl/LJpti4Vt/e7+e+fpvdx/j52Hif6+dt
OrIrVnuzdfSZTf7ok106ffmKk04qXzGMEIDAfggs/vz3L5uPvvXB5pPp/vQHPpluP9ipAgEIQGAe
BOrm6u8kcl7AnscW6RICEIAABHIJ1BfrdbVummq9XudqkAcBCEAAAkdKoD4/P9/cIOxmwT8IQAAC
EICAJ1Cfnq2qi4uLym4W/IMABCAAAQh4AvWbd++q8/fvq7PVytuZQwACEIAABKrl61cvq/PVN6vT
09Mbv96oXz+c4q8jqic7P/U59Cx9rnLGaliedGKu7NK2McZ4X5xvm296XiPW9j7V9jF9fuVsM/oa
fbVVx8fJljP62sqP2j4m+pTTNQ7NV1xOja76c/aJid9D5ONjos/ntc2H5isup0Zb7Tnaly9f/rda
rVbVu7dvNxczgZnyZuzQcvpUjj90s9mXt/XtXToxTnavNUZ/23zrJ6WhPlM+31+fXzrbjn3nF/lt
W0/5Q/aXilH+kHFovuKGaN6VGDGJ52922VIxY/gMzVfcGO1jjV2++s9X1erstHr37s2x7vF6X/pG
uzZkTKb8zaPecveZm5eBMZly6Prb8huar7gkBIytBMQt9/tkaL7iWhu5Y47l65dfV+ers+rs7etb
Wxcsfyiy+WD55bO15hY31G+xPk81lK/1IUf1kuoz9jUkJub49bb5Xmtf81TPYla6B9WO9WQvXX+I
vnqxHjUfkqeYVI72K1/Ull8aXaM0FONz5cvV9/nSt1F2bzvUXL3EPR6qnynUXfz0F79qfvzd71SP
n35W/ftff7t1YG3fJGreQzWb1jb3oKUjf2odfV5P8W11ZR8yqo5io7bsXaM0fK63aS4NHydbHJVj
sZorZky+cjT63Kg7JMbnKz41StvHp2yW22b3ukNifHxKN2po7fPUb8pncfL7nNS8L19+6cV1StPb
UvHR1rf2en3zqGXx0RbXYzVjvtZeJ/LyPpvLH+1xndL2+fJLL66j3l1ZL1dvXlXr96vqfHU6eM+C
15Ug0F0xbb4h+m25Q+y+N6tlX942RKMrRv2bpuZd8dGnnFS+fDHH9+/nFm9fsmlUfkrPx8R85XWN
Kc2u+JRPGr6XVFy0Wbx6lk8aKU3FKsZy/Dzll27b2JevPpRva58j+yHG2Nuue7B9iqm0tXfV1tr8
ivU2P0/5pds29uWrD+Xb2ufIflfG5fnZ22p98b5an9/8FViD0nYAY4CNiRX0nBzlTmXcdg9t+W32
qezb+ti2Rz1Ic3Usb1uNEjzjfqbWY+xH612z4Hx2TbSsXr1+f141zXpzo4il9E1d6psl1juWtbjl
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
--000000000000041fd30577b2a7b2
Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_jmzy5pzh1>
X-Attachment-Id: ii_jmzy5pzh1

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
--000000000000041fd30577b2a7b2--
