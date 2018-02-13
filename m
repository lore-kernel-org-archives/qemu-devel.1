Received: from eggs.gnu.org ([2001:4830:134:3::10]:33348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elfnb-0006Wd-7W
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elfna-0006LG-HP
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:59:27 -0500
References: <20180118164439.2120-1-ptoscano@redhat.com>
	<19874fff-b615-593f-c0a4-16954fa2732c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3b37bdc-8694-10dc-6b85-eecd6d0147f1@redhat.com>
Date: Tue, 13 Feb 2018 12:59:18 -0600
MIME-Version: 1.0
In-Reply-To: <19874fff-b615-593f-c0a4-16954fa2732c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4] ssh: switch from libssh2
 to libssh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, rjones@redhat.com

On 02/13/2018 12:49 PM, Max Reitz wrote:
> On 2018-01-18 17:44, Pino Toscano wrote:
>> Rewrite the implementation of the ssh block driver to use libssh instead
>> of libssh2.  The libssh library has various advantages over libssh2:
>> - easier API for authentication (for example for using ssh-agent)
>> - easier API for known_hosts handling
>> - supports newer types of keys in known_hosts
>>

>> @@ -628,6 +570,8 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
>>       Error *local_err = NULL;
>>       const char *user, *path, *host_key_check;
>>       long port = 0;
>> +    unsigned long portU = 0;
> 
> I was about to say: How about making port an unsigned long and swapping
> the qemu_strtol() for a qemu_strtoul()?
> 
> But I think you'd rather want an unsigned int instead (and that won't
> work with qemu_strtoul()).

Dan has a pending patch that adds qemu_strtoi() and qemu_strtoui(), when 
we want to deal with parsing to ints.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
