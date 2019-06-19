Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DAC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03A5208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03A5208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdaAu-0004fq-UC
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 08:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hdaA0-0004EN-Nw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hda9z-0002Mw-93
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:57:56 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hda9y-0002KW-Uw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:57:55 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MlNgx-1iKrz937JF-00lqIt; Wed, 19 Jun 2019 14:56:46 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1559903719-7162-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1559903719-7162-4-git-send-email-aleksandar.markovic@rt-rk.com>
 <6ceaa114-887b-b060-17b2-7d801e9f266b@vivier.eu>
 <DM5PR22MB1658725207C159300EEC786AD2E50@DM5PR22MB1658.namprd22.prod.outlook.com>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f2e44145-622d-ccff-1b4d-57d603abe80f@vivier.eu>
Date: Wed, 19 Jun 2019 14:56:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <DM5PR22MB1658725207C159300EEC786AD2E50@DM5PR22MB1658.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kUhmHEIKRrYjG7mZkgZ9bGyRFIJRk4GIg3oqRSFQDxdzCDJWptW
 lhUrf/LJaUo2apglWU4UrKI99j2mk3xQJPV4KkacxzfaZpHocq9SHI1SIJCr5g69qJHUSRR
 JEJ6iyW7TX9Ad3jRm7qi7ZIS3ixlPOgqKHJbYdC8U2pg5TMIfoWTAYj03KnUJnFC35ce0M0
 xcDYDZ1d34/lhSh7IqGPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3D6VmJJnMKA=:9/EEw9sjN5KQOUdRbfn162
 96o+VpVUBfSEmn0m3TGYwnL/sVhX6lpO29HKNSXwok9uzQEf9WIFxOT+6BKD2isjKopwS2HOO
 nfL0YdQsIsPamqpqIv96vp6TVN9F92BlcqUFdXPC+/NYAQ/7Nz2CxuGk69P6A4W2QsbDMEOHn
 V3MWgEQatfiFnldLJzu30QDoUXFXyCHcXoCWtpTUIM3HblblglVJZBm3dq18jLwl3r2iTBbQr
 48e4elwIuTZQ0YuzdpoOdo6ymniMgWG5C0coyStPcJ5612VaJiixIgL32irY5hcmJqpR8JmJk
 1PWII6w/2ucSaf2Od7yzmBiJuH6NF9NHu5WwqToNZE2YT014eLhoQsE2YzedvTitt/Xc51tyB
 JQhjS646EX+IZ6uKRuqEbWXSgKmBdw8AHUEp9Rj+5Qtad4sb+3RdZez01BQLpOhqb3/+XjyRY
 6IRDn3V+OgcXhoH30e8NGnxPr/ZMv9Wav4UThSMUXU2uGEA5OiVEKkj1N/JADox5rvcp3/Wrp
 gmHPEleVTaLfjMCNstzXpCEDFO1qGPzQ8+h8iwwg0ID+hROGwoJzTwfmoS/u9+yEWsn+Z7iLj
 eyRx2hDEXuLHySwPlrpxOPqgHP3aVQuHNsdXirvoH1/uLRq9fsqFKAt/QRgmJnHcmRvjof1A0
 KPcFQuC23ImH/7QfqPzkO642s3urU/fW91YDhtOahq/ZkuBmCzHXN52tIemRmbKqwtEkGHbNf
 7jYTBGtzGyWLYV1VlzduXyhrOoP/BY7MLw3KKXcK28bTzpWW2J4trP8mEl0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH v10 3/3] linux-user: Add support for
 statx() syscall
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/06/2019 à 14:12, Aleksandar Rikalo a écrit :
> Hi Laurent,
...
>> BTW, do we really need to emulate the syscall if it is not available?
>>
>> I think the user-space application calling statx() should be ready to
>> receive ENOSYS and define some kinds of fallback (like you do below). So
>> it should not be done by QEMU.
> 
> nanoMIPS linux port doesn't support any of "stats" but the statx, so there
> is no fallback in nanoMIPS user-space applications.
> 
> I think, we can expect similar situation for any new linux port.

OK, I understand, so I agree, we need the emulation part.

>> Why do we divide the case in two parts, fstatat() should work here too.
> 
> fstat() uses file descriptor, but here we have string which represents
> file name with absolute path.
> 
> All system calls from 'stat' group whose name starts with letter f require
> file descriptor as an argument. Whereas remaining system calls require
> file name / path as string. In that sense, statx() is a hybrid between
> the two, hence the solution I propose.

but fstatat() works like statx(), it accepts file descriptor and path.

So what I proposed is to replace:

+            } else {
+                if (dirfd == AT_FDCWD) {
+                    /*
+                     * By pathname relative to the current working directory
+                     */
+                    ret = get_errno(stat(path(p), &st));
+                    unlock_user(p, arg2, 0);
+                } else {
+                    /*
+                     * By pathname relative to the directory referred to by
+                     * the file descriptor 'dirfd'
+                     */
+                    ret = get_errno(fstatat(dirfd, path(p), &st, flags));
+                    unlock_user(p, arg2, 0);
+                }
+            }

by something like;

+            } else {
+                ret = get_errno(fstatat(dirfd, path(p), &st, flags));
+            }

as fstatat() also accepts AT_FDCWD.

Moreover in kernel vfs_fstatat() calls vfs_statx():

static inline int vfs_fstatat(int dfd, const char __user *filename,
                              struct kstat *stat, int flags)
{
        return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
                         stat, STATX_BASIC_STATS);
}

so maybe all the cases can be emulated by fstatat()?

Or did I miss something?

Thanks,
Laurent



