Received: from eggs.gnu.org ([2001:4830:134:3::10]:41696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLTsq-0006ZE-5D
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLTsp-0004B2-By
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:05:08 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gLTsn-0003TE-96
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 09:05:05 -0500
Received: by mail-oi1-x244.google.com with SMTP id 192-v6so3817013oii.6
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 06:04:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181110135335.pw35cgnbyuzgbecx@function>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
	<20181110134548.14741-11-marcandre.lureau@redhat.com>
	<20181110135335.pw35cgnbyuzgbecx@function>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 10 Nov 2018 14:04:10 +0000
Message-ID: <CAFEAcA93Vszet7tq4gDm7UhoHmf2MBeBvHM_spxX-8A34-LEBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 10/13] slirp: improve subprocess
 socket creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 10 November 2018 at 13:53, Samuel Thibault <samuel.thibault@gnu.org> wro=
te:
> Marc-Andr=C3=A9 Lureau, le sam. 10 nov. 2018 17:45:45 +0400, a ecrit:
>> @@ -163,23 +183,14 @@ fork_exec(struct socket *so, const char *ex)
>>               exit(1);
>>
>>        default:
>> -             qemu_add_child_watch(pid);
>> -                /*
>> -                 * XXX this could block us...
>> -                 * XXX Should set a timer here, and if accept() doesn't
>> -                 * return after X seconds, declare it a failure
>> -                 * The only reason this will block forever is if socket=
()
>> -                 * of connect() fail in the child process
>> -                 */
>
> At least this got fixed by Peter lately, so please rebase.

My patches aren't in master yet, though -- do you have a
public slirp tree that slirp patches should be based on?
(I'm assuming you're planning a pull request too.)

thanks
-- PMM
