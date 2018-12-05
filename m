Received: from eggs.gnu.org ([2001:4830:134:3::10]:48449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUf2g-00061Q-3J
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUf2b-0004lo-9p
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:49:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gUf2b-0004lT-3t
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:49:09 -0500
References: <1f7db2e27758f26d4c10f7a8ed1d8232635f6909.1536044449.git.pkrempa@redhat.com>
	<20181004113412.GI21448@angien.pipo.sk>
	<20181205123337.GI799@angien.pipo.sk>
	<CAJ+F1CLr5_nB2hpXJrhMeJnsXjME8k+0s90wZHw-H_qsQht63A@mail.gmail.com>
	<87tvjsq71s.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c72d80b5-5996-eb78-58ca-6764278dab54@redhat.com>
Date: Wed, 5 Dec 2018 15:49:06 -0600
MIME-Version: 1.0
In-Reply-To: <87tvjsq71s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi: Add vim magic modelines for qapi
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Peter Krempa <pkrempa@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 12/5/18 10:20 AM, Markus Armbruster wrote:

>> The vim plugin doesn't have an equivalent, however, the documentation
>> suggest vim_filetype, but you need to add
>> to .vimrc:
>>
>> function! FiletypeHook(config)
>>      if has_key(a:config, 'vim_filetype')
>>          let &filetype = a:config['vim_filetype']
>>      endif
>>
>>      return 0   " Return 0 to show no error happened
>> endfunction
>>
>> call editorconfig#AddNewHook(function('FiletypeHook'))
>>
>> I think this is a better solution than having to add modelines
>> everywhere, what do you think?
> 
> These .json files are not valid JSON.  They *are* valid Python (except
> for a few tests, which could perhaps be fixed).  Makes me wonder why on
> earth we insist on naming them .json and create all this trouble.

I've previously posted patches that bulk-renames the QAPI files from 
.json to .qapi, but too close to a release cycle to be applied at the 
time. I'd have to refresh them to match new files in the meantime, but 
as long as we are arguing that editorconfig is a smart way to go, it's a 
fairly simple tweak to editorconfig to match the preferred suffix we use 
for QAPI files.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
