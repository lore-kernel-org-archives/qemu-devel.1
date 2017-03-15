Received: from eggs.gnu.org ([2001:4830:134:3::10]:60422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1coAsp-0000aZ-VP
	for Qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1coAsn-0007j1-Q0
	for Qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:30:40 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:34754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1coAsn-0007in-K9
	for Qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:30:37 -0400
Received: by mail-ua0-x243.google.com with SMTP id 72so1501883uaf.1
	for <Qemu-devel@nongnu.org>; Wed, 15 Mar 2017 08:30:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAF++6AN8-pKhPKNQPDnCkXzQdqo4hPTH6eJetuzQXmsBkDXRNA@mail.gmail.com>
References: <CAF++6APFk2KY-7yFYtsgcTwn31RCf_Wxucp3eTLbB2e1c5QAyg@mail.gmail.com>
	<CAFEAcA9NPoujRE47pyNEui-DwxwisNpmGNp0w4B_+_mwbuV_4Q@mail.gmail.com>
	<CAF++6AN8-pKhPKNQPDnCkXzQdqo4hPTH6eJetuzQXmsBkDXRNA@mail.gmail.com>
From: James Hanley <jhanley@dgtlrift.com>
Date: Wed, 15 Mar 2017 11:30:36 -0400
Message-ID: <CAF++6AMLAdzz0npAQYwenDOZJNqLgp+5oLNSR_R-XqFxhenKaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] submodule-update queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <Qemu-devel@nongnu.org>

It would appear that the HTTP versions of the repo URLs are /not/
referencing the same backend....

jim@jim-VirtualBox:~$ git ls-remote http://git.qemu-project.org/git/dtc.git
3b9c97093d6e1067f4d24d2bff32f3dd24e0751e HEAD
827ac8eca016c39b13fc916bbdb16f9f2fe3c34c refs/heads/expressions
3b9c97093d6e1067f4d24d2bff32f3dd24e0751e refs/heads/master
17dab7023959256224e800dd77cae57d8ecfaec0 refs/heads/multi-v1-tags
5426757b714e4c142da488fe685220b732f69d7b refs/heads/testing
827ac8eca016c39b13fc916bbdb16f9f2fe3c34c refs/remotes/github/expressions
3b9c97093d6e1067f4d24d2bff32f3dd24e0751e refs/remotes/github/master
17dab7023959256224e800dd77cae57d8ecfaec0 refs/remotes/github/multi-v1-tags
5426757b714e4c142da488fe685220b732f69d7b refs/remotes/github/testing
827ac8eca016c39b13fc916bbdb16f9f2fe3c34c refs/remotes/origin/expressions
120775eb1cf39f8dcecd695c3ff1cfef8aeb669d refs/remotes/origin/master
17dab7023959256224e800dd77cae57d8ecfaec0 refs/remotes/origin/multi-v1-tags
f5aa792d81f5911eff088e4f88c0cd0a11ea9ca0 refs/tags/dwg-last
0a1018321b08f89d0f1942c77802aa777a82d437 refs/tags/v1.0.0
5cb1fbdd7cf82e1909e27c81073cf3272cb63fa3 refs/tags/v1.0.0^{}
8e4751ca3600a2d82365e7e9d806f2bab9b81d56 refs/tags/v1.0.0-rc1
74ce242bf3307c7ec77b9ddfff443c247ac8c0a3 refs/tags/v1.0.0-rc1^{}
38738612dec55c0262de2192cbe655f499b8c5de refs/tags/v1.1.0
202863e4dd681d17c06a82943f49485bf7860633 refs/tags/v1.1.0^{}
2d38c152a6cbcd6fcd7a2f2535d3bc8860c975f9 refs/tags/v1.1.0-rc1
7364cc79b5fa11e416dce01802139bc87d690118 refs/tags/v1.1.0-rc1^{}
427b0062114703674688aa581d13499b1b2da896 refs/tags/v1.2.0
52c356d81b1b5b5426f53655e782c37793c3637e refs/tags/v1.2.0^{}
33ea8e2705c6905edcabda65dfa92af56716056b refs/tags/v1.2.0-rc1
f8bf4bfc8796b46e6086a52f0cd6c1f9ed58645a refs/tags/v1.2.0-rc1^{}
a532a5d2148e6a644bb56f7aa3d29297d19e30de refs/tags/v1.2.0-rc2
17773b0e5148c5ae281ee21492c871292cb7de20 refs/tags/v1.2.0-rc2^{}
00e38ce99a600e146aa20eac082b8d7d8ec70711 refs/tags/v1.3.0
bc895d6d09695d05ceb8b52486ffe861d6cfbdde refs/tags/v1.3.0^{}
6d109a2e4885896d2665d4bbcc5bc985110b0950 refs/tags/v1.4.0
65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf refs/tags/v1.4.0^{}
29a9b5177c0bc192f7881b940932f903aca9c360 refs/tags/v1.4.1
302fca9f4c283e1994cf0a5a9ce1cf43ca15e6d2 refs/tags/v1.4.1^{}
24ec6e01bca89179d744d836fe94f2b459abd03d refs/tags/v1.4.2
ec02b34c05be04f249ffaaca4b666f5246877dea refs/tags/v1.4.2^{}
jim@jim-VirtualBox:~$


Note that the tags for 1.4.3 and 1.4.4 are missing... Are the tags not
"fetched" with the synchronization?

On Mon, Mar 6, 2017 at 11:50 AM, James Hanley <jhanley@dgtlrift.com> wrote:

> I'm still seeing the same error - the only change I have in my clone is
> the following so that the submodules are accessible across our firewall -
> should the http URLs be referencing the same backend repo as the git URLs?:
> jim@jim-VirtualBox:~/project/test_qemu_repo/qemu$ git diff -v
> 6865190577f240d0c0f15d6537a893d771596404^ 6865190577f240d0c0f15d6537a893
> d771596404
> diff --git a/.gitmodules b/.gitmodules
> index ca323b4..0156c06 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -1,36 +1,36 @@
>  [submodule "roms/vgabios"]
>         path = roms/vgabios
> -       url = git://git.qemu-project.org/vgabios.git/
> +       url = http://git.qemu-project.org/git/vgabios.git
>  [submodule "roms/seabios"]
>         path = roms/seabios
> -       url = git://git.qemu-project.org/seabios.git/
> +       url = http://git.qemu-project.org/git/seabios.git
>  [submodule "roms/SLOF"]
>         path = roms/SLOF
> -       url = git://git.qemu-project.org/SLOF.git
> +       url = http://git.qemu-project.org/git/SLOF.git
>  [submodule "roms/ipxe"]
>         path = roms/ipxe
> -       url = git://git.qemu-project.org/ipxe.git
> +       url = http://git.qemu-project.org/git/ipxe.git
>  [submodule "roms/openbios"]
>         path = roms/openbios
> -       url = git://git.qemu-project.org/openbios.git
> +       url = http://git.qemu-project.org/git/openbios.git
>  [submodule "roms/openhackware"]
>         path = roms/openhackware
> -       url = git://git.qemu-project.org/openhackware.git
> +       url = http://git.qemu-project.org/git/openhackware.git
>  [submodule "roms/qemu-palcode"]
>         path = roms/qemu-palcode
> -       url = git://github.com/rth7680/qemu-palcode.git
> +       url = https://github.com/rth7680/qemu-palcode.git
>  [submodule "roms/sgabios"]
>         path = roms/sgabios
> -       url = git://git.qemu-project.org/sgabios.git
> +       url = http://git.qemu-project.org/git/sgabios.git
>  [submodule "pixman"]
>         path = pixman
> -       url = git://anongit.freedesktop.org/pixman
> +       url = https://anongit.freedesktop.org/git/pixman.git
>  [submodule "dtc"]
>         path = dtc
> -       url = git://git.qemu-project.org/dtc.git
> +       url = http://git.qemu-project.org/git/dtc.git
>  [submodule "roms/u-boot"]
>         path = roms/u-boot
> -       url = git://git.qemu-project.org/u-boot.git
> +       url = http://git.qemu-project.org/git/u-boot.git
>  [submodule "roms/skiboot"]
>         path = roms/skiboot
> -       url = git://git.qemu.org/skiboot.git
> +       url = http://git.qemu-project.org/git/skiboot.git
>
>
> On Sat, Mar 4, 2017 at 7:47 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On 3 March 2017 at 19:45, James Hanley <jhanley@dgtlrift.com> wrote:
>> > I'm trying to clone clean and I'm getting the following when initing the
>> > submodules updated:
>>
>> > It's unclear to me what should be done for a pristine clone - is there a
>> > step missing from pulling those submodules?
>>
>> I just did:
>>  git clone git://git.qemu-project.org/qemu.git
>>  cd qemu
>>  git submodule init
>>  git submodule update
>>
>> and that worked for me.
>>
>> (We do occasionally accidentally introduce an error where we
>> update the submodule but the qemu-project.org mirror of a
>> git repo hasn't yet moved forward to include the reference.
>> But it seems to all be OK at the moment.)
>>
>> As an aside you typically don't need all the submodules if
>> you're just interested in building QEMU. (You might need
>> the dtc module but configure will tell you if you do and
>> also what command to ues to just get the dtc submodule
>> and not anything else.)
>>
>> thanks
>> -- PMM
>>
>
>
