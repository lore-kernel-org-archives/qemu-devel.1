Received: from eggs.gnu.org ([208.118.235.92]:55041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1geVsQ-00030o-4d
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1geVsF-0006xE-IS
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:03:19 -0500
Date: Wed, 2 Jan 2019 10:02:58 +0800
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Message-ID: <20190102020258.GA26683@byw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] (no subject)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, qemu-block@nongnu.org, famz@redhat.com, atumball@redhat.com, mchristi@redhat.com, pkalever@redhat.com, pbonzini@redhat.com, xiubli@redhat.com, baiyaowei@cmss.chinamobile.com

baiyaowei@cmss.chinamobile.com
Bcc: 
Subject: Re: [Qemu-devel] [PATCH] tcmu: Introduce qemu-tcmu utility
Reply-To: baiyaowei@cmss.chinamobile.com
In-Reply-To: <20190102015321.GA26514@byw>

Add Xiubo.

On Wed, Jan 02, 2019 at 09:53:21AM +0800, Yaowei Bai wrote:
> Ping.
> 
> BTW, it should be update docker image to install glib to fix this.
> 
> On Wed, Dec 26, 2018 at 12:19:48AM -0800, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com/
> > 
> > 
> > 
> > Hi,
> > 
> > This series seems to have some coding style problems. See output below for
> > more information:
> > 
> > Message-id: 1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com
> > Type: series
> > Subject: [Qemu-devel] [PATCH] tcmu: Introduce qemu-tcmu utility
> > 
> > === TEST SCRIPT BEGIN ===
> > #!/bin/bash
> > 
> > BASE=base
> > n=1
> > total=$(git log --oneline $BASE.. | wc -l)
> > failed=0
> > 
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > git config --local diff.algorithm histogram
> > 
> > commits="$(git log --format=%H --reverse $BASE..)"
> > for c in $commits; do
> >     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
> >     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
> >         failed=1
> >         echo
> >     fi
> >     n=$((n+1))
> > done
> > 
> > exit $failed
> > === TEST SCRIPT END ===
> > 
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > Switched to a new branch 'test'
> > 52869e1 tcmu: Introduce qemu-tcmu utility
> > 
> > === OUTPUT BEGIN ===
> > Checking PATCH 1/1: tcmu: Introduce qemu-tcmu utility...
> > WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> > #157: 
> > new file mode 100644
> > 
> > ERROR: trailing whitespace
> > #329: FILE: qemu-tcmu.c:51:
> > +"Usage:\n" $
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #466: FILE: qemu-tcmu.c:188:
> > +    /* now when the initialization is (almost) complete, chdir("/")
> > 
> > WARNING: Block comments use a trailing */ on a separate line
> > #467: FILE: qemu-tcmu.c:189:
> > +     * to free any busy filesystems */
> > 
> > ERROR: code indent should never use tabs
> > #525: FILE: tcmu/helper.c:16:
> > +^Iuint8_t *cdb,$
> > 
> > ERROR: code indent should never use tabs
> > #526: FILE: tcmu/helper.c:17:
> > +^Istruct iovec *iovec,$
> > 
> > ERROR: code indent should never use tabs
> > #527: FILE: tcmu/helper.c:18:
> > +^Isize_t iov_cnt)$
> > 
> > ERROR: code indent should never use tabs
> > #529: FILE: tcmu/helper.c:20:
> > +^Iuint8_t buf[36];$
> > 
> > ERROR: code indent should never use tabs
> > #531: FILE: tcmu/helper.c:22:
> > +^Imemset(buf, 0, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #533: FILE: tcmu/helper.c:24:
> > +^Ibuf[2] = 0x05; /* SPC-3 */$
> > 
> > ERROR: code indent should never use tabs
> > #534: FILE: tcmu/helper.c:25:
> > +^Ibuf[3] = 0x02; /* response data format */$
> > 
> > ERROR: code indent should never use tabs
> > #536: FILE: tcmu/helper.c:27:
> > +^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #537: FILE: tcmu/helper.c:28:
> > +^I * A Third-Party Copy (3PC)$
> > 
> > ERROR: code indent should never use tabs
> > #538: FILE: tcmu/helper.c:29:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #539: FILE: tcmu/helper.c:30:
> > +^I * Enable the XCOPY$
> > 
> > ERROR: code indent should never use tabs
> > #540: FILE: tcmu/helper.c:31:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #541: FILE: tcmu/helper.c:32:
> > +^Ibuf[5] = 0x08;$
> > 
> > ERROR: code indent should never use tabs
> > #543: FILE: tcmu/helper.c:34:
> > +^Ibuf[7] = 0x02; /* CmdQue */$
> > 
> > ERROR: code indent should never use tabs
> > #545: FILE: tcmu/helper.c:36:
> > +^Imemcpy(&buf[8], "LIO-ORG ", 8);$
> > 
> > ERROR: code indent should never use tabs
> > #546: FILE: tcmu/helper.c:37:
> > +^Imemset(&buf[16], 0x20, 16);$
> > 
> > ERROR: code indent should never use tabs
> > #547: FILE: tcmu/helper.c:38:
> > +^Imemcpy(&buf[16], "TCMU device", 11);$
> > 
> > ERROR: code indent should never use tabs
> > #548: FILE: tcmu/helper.c:39:
> > +^Imemcpy(&buf[32], "0002", 4);$
> > 
> > ERROR: code indent should never use tabs
> > #549: FILE: tcmu/helper.c:40:
> > +^Ibuf[4] = 31; /* Set additional length to 31 */$
> > 
> > ERROR: code indent should never use tabs
> > #551: FILE: tcmu/helper.c:42:
> > +^Itcmu_memcpy_into_iovec(iovec, iov_cnt, buf, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #552: FILE: tcmu/helper.c:43:
> > +^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #558: FILE: tcmu/helper.c:49:
> > +^Iif (c >= '0' && c <= '9') {$
> > 
> > ERROR: code indent should never use tabs
> > #559: FILE: tcmu/helper.c:50:
> > +^I^I*val = c - '0';$
> > 
> > ERROR: code indent should never use tabs
> > #560: FILE: tcmu/helper.c:51:
> > +^I^Ireturn true;$
> > 
> > ERROR: code indent should never use tabs
> > #561: FILE: tcmu/helper.c:52:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #562: FILE: tcmu/helper.c:53:
> > +^Iif (c >= 'a' && c <= 'f') {$
> > 
> > ERROR: code indent should never use tabs
> > #563: FILE: tcmu/helper.c:54:
> > +^I^I*val = c - 'a' + 10;$
> > 
> > ERROR: code indent should never use tabs
> > #564: FILE: tcmu/helper.c:55:
> > +^I^Ireturn true;$
> > 
> > ERROR: code indent should never use tabs
> > #565: FILE: tcmu/helper.c:56:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #566: FILE: tcmu/helper.c:57:
> > +^Iif (c >= 'A' && c <= 'F') {$
> > 
> > ERROR: code indent should never use tabs
> > #567: FILE: tcmu/helper.c:58:
> > +^I^I*val = c - 'A' + 10;$
> > 
> > ERROR: code indent should never use tabs
> > #568: FILE: tcmu/helper.c:59:
> > +^I^Ireturn true;$
> > 
> > ERROR: code indent should never use tabs
> > #569: FILE: tcmu/helper.c:60:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #570: FILE: tcmu/helper.c:61:
> > +^Ireturn false;$
> > 
> > ERROR: code indent should never use tabs
> > #574: FILE: tcmu/helper.c:65:
> > +^Istruct tcmu_device *dev,$
> > 
> > ERROR: code indent should never use tabs
> > #575: FILE: tcmu/helper.c:66:
> > +^Iuint8_t *cdb,$
> > 
> > ERROR: code indent should never use tabs
> > #576: FILE: tcmu/helper.c:67:
> > +^Istruct iovec *iovec,$
> > 
> > ERROR: code indent should never use tabs
> > #577: FILE: tcmu/helper.c:68:
> > +^Isize_t iov_cnt)$
> > 
> > ERROR: code indent should never use tabs
> > #579: FILE: tcmu/helper.c:70:
> > +^Iswitch (cdb[2]) {$
> > 
> > ERROR: code indent should never use tabs
> > #580: FILE: tcmu/helper.c:71:
> > +^Icase 0x0: /* Supported VPD pages */$
> > 
> > ERROR: code indent should never use tabs
> > #581: FILE: tcmu/helper.c:72:
> > +^I{$
> > 
> > ERROR: code indent should never use tabs
> > #582: FILE: tcmu/helper.c:73:
> > +^I^Ichar data[16];$
> > 
> > ERROR: code indent should never use tabs
> > #584: FILE: tcmu/helper.c:75:
> > +^I^Imemset(data, 0, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #586: FILE: tcmu/helper.c:77:
> > +^I^I/* data[1] (page code) already 0 */$
> > 
> > ERROR: code indent should never use tabs
> > #587: FILE: tcmu/helper.c:78:
> > +^I^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #588: FILE: tcmu/helper.c:79:
> > +^I^I  *  spc4r22 7.7.13 The supported VPD page list shall contain$
> > 
> > WARNING: Block comments should align the * on each line
> > #588: FILE: tcmu/helper.c:79:
> > +               /*
> > +                 *  spc4r22 7.7.13 The supported VPD page list shall contain
> > 
> > ERROR: code indent should never use tabs
> > #589: FILE: tcmu/helper.c:80:
> > +^I^I  *  a list of all VPD page codes (see 7.7) implemented by the$
> > 
> > WARNING: line over 80 characters
> > #590: FILE: tcmu/helper.c:81:
> > +                 *  logical unit in ascending order beginning with page code 00h
> > 
> > ERROR: code indent should never use tabs
> > #590: FILE: tcmu/helper.c:81:
> > +^I^I  *  logical unit in ascending order beginning with page code 00h$
> > 
> > ERROR: code indent should never use tabs
> > #591: FILE: tcmu/helper.c:82:
> > +^I^I  */$
> > 
> > ERROR: code indent should never use tabs
> > #592: FILE: tcmu/helper.c:83:
> > +^I^Idata[4] = 0x00;$
> > 
> > ERROR: code indent should never use tabs
> > #593: FILE: tcmu/helper.c:84:
> > +^I^Idata[5] = 0x80;$
> > 
> > ERROR: code indent should never use tabs
> > #594: FILE: tcmu/helper.c:85:
> > +^I^Idata[6] = 0x83;$
> > 
> > ERROR: code indent should never use tabs
> > #595: FILE: tcmu/helper.c:86:
> > +^I^Idata[7] = 0xb0;$
> > 
> > ERROR: code indent should never use tabs
> > #596: FILE: tcmu/helper.c:87:
> > +^I^Idata[8] = 0xb1;$
> > 
> > ERROR: code indent should never use tabs
> > #597: FILE: tcmu/helper.c:88:
> > +^I^Idata[9] = 0xb2;$
> > 
> > ERROR: code indent should never use tabs
> > #599: FILE: tcmu/helper.c:90:
> > +^I^Idata[3] = 6;$
> > 
> > ERROR: code indent should never use tabs
> > #601: FILE: tcmu/helper.c:92:
> > +^I^Itcmu_memcpy_into_iovec(iovec, iov_cnt, data, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #602: FILE: tcmu/helper.c:93:
> > +^I^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #603: FILE: tcmu/helper.c:94:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #604: FILE: tcmu/helper.c:95:
> > +^Ibreak;$
> > 
> > ERROR: code indent should never use tabs
> > #605: FILE: tcmu/helper.c:96:
> > +^Icase 0x80: /* Unit Serial Number */$
> > 
> > ERROR: code indent should never use tabs
> > #606: FILE: tcmu/helper.c:97:
> > +^I{$
> > 
> > ERROR: code indent should never use tabs
> > #607: FILE: tcmu/helper.c:98:
> > +^I^Ichar data[512];$
> > 
> > ERROR: code indent should never use tabs
> > #608: FILE: tcmu/helper.c:99:
> > +^I^Ichar *wwn;$
> > 
> > ERROR: code indent should never use tabs
> > #609: FILE: tcmu/helper.c:100:
> > +^I^Iuint32_t len;$
> > 
> > ERROR: code indent should never use tabs
> > #611: FILE: tcmu/helper.c:102:
> > +^I^Imemset(data, 0, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #613: FILE: tcmu/helper.c:104:
> > +^I^Idata[1] = 0x80;$
> > 
> > ERROR: code indent should never use tabs
> > #615: FILE: tcmu/helper.c:106:
> > +^I^Iwwn = tcmu_cfgfs_dev_get_wwn(dev);$
> > 
> > ERROR: code indent should never use tabs
> > #616: FILE: tcmu/helper.c:107:
> > +^I^Iif (!wwn)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #616: FILE: tcmu/helper.c:107:
> > +               if (!wwn)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #617: FILE: tcmu/helper.c:108:
> > +^I^I^Ireturn TCMU_STS_HW_ERR;$
> > 
> > ERROR: code indent should never use tabs
> > #619: FILE: tcmu/helper.c:110:
> > +^I^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #620: FILE: tcmu/helper.c:111:
> > +^I^I * The maximum length of the unit_serial has limited$
> > 
> > ERROR: code indent should never use tabs
> > #621: FILE: tcmu/helper.c:112:
> > +^I^I * to 254 Bytes in kernel, so here limit to 256 Bytes$
> > 
> > ERROR: code indent should never use tabs
> > #622: FILE: tcmu/helper.c:113:
> > +^I^I * will be enough.$
> > 
> > ERROR: code indent should never use tabs
> > #623: FILE: tcmu/helper.c:114:
> > +^I^I */$
> > 
> > ERROR: code indent should never use tabs
> > #624: FILE: tcmu/helper.c:115:
> > +^I^Ilen = snprintf(&data[4], 256, "%s", wwn);$
> > 
> > ERROR: code indent should never use tabs
> > #625: FILE: tcmu/helper.c:116:
> > +^I^Idata[3] = len + 1;$
> > 
> > ERROR: code indent should never use tabs
> > #627: FILE: tcmu/helper.c:118:
> > +^I^Itcmu_memcpy_into_iovec(iovec, iov_cnt, data, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #629: FILE: tcmu/helper.c:120:
> > +^I^Ifree(wwn);$
> > 
> > ERROR: code indent should never use tabs
> > #630: FILE: tcmu/helper.c:121:
> > +^I^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #631: FILE: tcmu/helper.c:122:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #632: FILE: tcmu/helper.c:123:
> > +^Ibreak;$
> > 
> > ERROR: code indent should never use tabs
> > #633: FILE: tcmu/helper.c:124:
> > +^Icase 0x83: /* Device identification */$
> > 
> > ERROR: code indent should never use tabs
> > #634: FILE: tcmu/helper.c:125:
> > +^I{$
> > 
> > ERROR: code indent should never use tabs
> > #635: FILE: tcmu/helper.c:126:
> > +^I^Ichar data[512];$
> > 
> > ERROR: code indent should never use tabs
> > #636: FILE: tcmu/helper.c:127:
> > +^I^Ichar *ptr, *p, *wwn;$
> > 
> > ERROR: code indent should never use tabs
> > #637: FILE: tcmu/helper.c:128:
> > +^I^Isize_t len, used = 0;$
> > 
> > ERROR: code indent should never use tabs
> > #638: FILE: tcmu/helper.c:129:
> > +^I^Iuint16_t *tot_len = (uint16_t*) &data[2];$
> > 
> > ERROR: "(foo*)" should be "(foo *)"
> > #638: FILE: tcmu/helper.c:129:
> > +               uint16_t *tot_len = (uint16_t*) &data[2];
> > 
> > ERROR: code indent should never use tabs
> > #639: FILE: tcmu/helper.c:130:
> > +^I^Ibool next;$
> > 
> > ERROR: code indent should never use tabs
> > #640: FILE: tcmu/helper.c:131:
> > +^I^Iint i;$
> > 
> > ERROR: code indent should never use tabs
> > #642: FILE: tcmu/helper.c:133:
> > +^I^Imemset(data, 0, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #644: FILE: tcmu/helper.c:135:
> > +^I^Idata[1] = 0x83;$
> > 
> > ERROR: code indent should never use tabs
> > #646: FILE: tcmu/helper.c:137:
> > +^I^Iwwn = tcmu_cfgfs_dev_get_wwn(dev);$
> > 
> > ERROR: code indent should never use tabs
> > #647: FILE: tcmu/helper.c:138:
> > +^I^Iif (!wwn)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #647: FILE: tcmu/helper.c:138:
> > +               if (!wwn)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #648: FILE: tcmu/helper.c:139:
> > +^I^I^Ireturn TCMU_STS_HW_ERR;$
> > 
> > ERROR: code indent should never use tabs
> > #650: FILE: tcmu/helper.c:141:
> > +^I^Iptr = &data[4];$
> > 
> > ERROR: code indent should never use tabs
> > #652: FILE: tcmu/helper.c:143:
> > +^I^I/* 1/5: T10 Vendor id */$
> > 
> > ERROR: code indent should never use tabs
> > #653: FILE: tcmu/helper.c:144:
> > +^I^Iptr[0] = 2; /* code set: ASCII */$
> > 
> > ERROR: code indent should never use tabs
> > #654: FILE: tcmu/helper.c:145:
> > +^I^Iptr[1] = 1; /* identifier: T10 vendor id */$
> > 
> > ERROR: code indent should never use tabs
> > #655: FILE: tcmu/helper.c:146:
> > +^I^Imemcpy(&ptr[4], "LIO-ORG ", 8);$
> > 
> > ERROR: code indent should never use tabs
> > #656: FILE: tcmu/helper.c:147:
> > +^I^Ilen = snprintf(&ptr[12], sizeof(data) - 16, "%s", wwn);$
> > 
> > ERROR: code indent should never use tabs
> > #658: FILE: tcmu/helper.c:149:
> > +^I^Iptr[3] = 8 + len + 1;$
> > 
> > ERROR: code indent should never use tabs
> > #659: FILE: tcmu/helper.c:150:
> > +^I^Iused += (uint8_t)ptr[3] + 4;$
> > 
> > ERROR: code indent should never use tabs
> > #660: FILE: tcmu/helper.c:151:
> > +^I^Iptr += used;$
> > 
> > ERROR: code indent should never use tabs
> > #662: FILE: tcmu/helper.c:153:
> > +^I^I/* 2/5: NAA binary */$
> > 
> > ERROR: code indent should never use tabs
> > #663: FILE: tcmu/helper.c:154:
> > +^I^Iptr[0] = 1; /* code set: binary */$
> > 
> > ERROR: code indent should never use tabs
> > #664: FILE: tcmu/helper.c:155:
> > +^I^Iptr[1] = 3; /* identifier: NAA */$
> > 
> > WARNING: line over 80 characters
> > #665: FILE: tcmu/helper.c:156:
> > +               ptr[3] = 16; /* body length for naa registered extended format */
> > 
> > ERROR: code indent should never use tabs
> > #665: FILE: tcmu/helper.c:156:
> > +^I^Iptr[3] = 16; /* body length for naa registered extended format */$
> > 
> > ERROR: code indent should never use tabs
> > #667: FILE: tcmu/helper.c:158:
> > +^I^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #668: FILE: tcmu/helper.c:159:
> > +^I^I * Set type 6 and use OpenFabrics IEEE Company ID: 00 14 05$
> > 
> > ERROR: code indent should never use tabs
> > #669: FILE: tcmu/helper.c:160:
> > +^I^I */$
> > 
> > ERROR: code indent should never use tabs
> > #670: FILE: tcmu/helper.c:161:
> > +^I^Iptr[4] = 0x60;$
> > 
> > ERROR: code indent should never use tabs
> > #671: FILE: tcmu/helper.c:162:
> > +^I^Iptr[5] = 0x01;$
> > 
> > ERROR: code indent should never use tabs
> > #672: FILE: tcmu/helper.c:163:
> > +^I^Iptr[6] = 0x40;$
> > 
> > ERROR: code indent should never use tabs
> > #673: FILE: tcmu/helper.c:164:
> > +^I^Iptr[7] = 0x50;$
> > 
> > ERROR: code indent should never use tabs
> > #675: FILE: tcmu/helper.c:166:
> > +^I^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #676: FILE: tcmu/helper.c:167:
> > +^I^I * Fill in the rest with a binary representation of WWN$
> > 
> > ERROR: code indent should never use tabs
> > #677: FILE: tcmu/helper.c:168:
> > +^I^I *$
> > 
> > ERROR: code indent should never use tabs
> > #678: FILE: tcmu/helper.c:169:
> > +^I^I * This implementation only uses a nibble out of every byte of$
> > 
> > ERROR: code indent should never use tabs
> > #679: FILE: tcmu/helper.c:170:
> > +^I^I * WWN, but this is what the kernel does, and it's nice for our$
> > 
> > ERROR: code indent should never use tabs
> > #680: FILE: tcmu/helper.c:171:
> > +^I^I * values to match.$
> > 
> > ERROR: code indent should never use tabs
> > #681: FILE: tcmu/helper.c:172:
> > +^I^I */$
> > 
> > ERROR: code indent should never use tabs
> > #682: FILE: tcmu/helper.c:173:
> > +^I^Inext = true;$
> > 
> > ERROR: code indent should never use tabs
> > #683: FILE: tcmu/helper.c:174:
> > +^I^Ifor (p = wwn, i = 7; *p && i < 20; p++) {$
> > 
> > ERROR: code indent should never use tabs
> > #684: FILE: tcmu/helper.c:175:
> > +^I^I^Iuint8_t val;$
> > 
> > ERROR: code indent should never use tabs
> > #686: FILE: tcmu/helper.c:177:
> > +^I^I^Iif (!char_to_hex(&val, *p))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #686: FILE: tcmu/helper.c:177:
> > +                       if (!char_to_hex(&val, *p))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #687: FILE: tcmu/helper.c:178:
> > +^I^I^I^Icontinue;$
> > 
> > ERROR: code indent should never use tabs
> > #689: FILE: tcmu/helper.c:180:
> > +^I^I^Iif (next) {$
> > 
> > ERROR: code indent should never use tabs
> > #690: FILE: tcmu/helper.c:181:
> > +^I^I^I^Inext = false;$
> > 
> > ERROR: code indent should never use tabs
> > #691: FILE: tcmu/helper.c:182:
> > +^I^I^I^Iptr[i++] |= val;$
> > 
> > ERROR: code indent should never use tabs
> > #692: FILE: tcmu/helper.c:183:
> > +^I^I^I} else {$
> > 
> > ERROR: code indent should never use tabs
> > #693: FILE: tcmu/helper.c:184:
> > +^I^I^I^Inext = true;$
> > 
> > ERROR: code indent should never use tabs
> > #694: FILE: tcmu/helper.c:185:
> > +^I^I^I^Iptr[i] = val << 4;$
> > 
> > ERROR: code indent should never use tabs
> > #695: FILE: tcmu/helper.c:186:
> > +^I^I^I}$
> > 
> > ERROR: code indent should never use tabs
> > #696: FILE: tcmu/helper.c:187:
> > +^I^I}$
> > 
> > ERROR: code indent should never use tabs
> > #698: FILE: tcmu/helper.c:189:
> > +^I^Iused += 20;$
> > 
> > ERROR: code indent should never use tabs
> > #699: FILE: tcmu/helper.c:190:
> > +^I^Iptr += 20;$
> > 
> > ERROR: code indent should never use tabs
> > #701: FILE: tcmu/helper.c:192:
> > +^I^I/* 3/6: Vendor specific */$
> > 
> > ERROR: code indent should never use tabs
> > #702: FILE: tcmu/helper.c:193:
> > +^I^Iptr[0] = 2; /* code set: ASCII */$
> > 
> > ERROR: code indent should never use tabs
> > #703: FILE: tcmu/helper.c:194:
> > +^I^Iptr[1] = 0; /* identifier: vendor-specific */$
> > 
> > ERROR: line over 90 characters
> > #705: FILE: tcmu/helper.c:196:
> > +               len = snprintf(&ptr[4], sizeof(data) - used - 4, "%s", tcmu_dev_get_cfgstring(dev));
> > 
> > ERROR: code indent should never use tabs
> > #705: FILE: tcmu/helper.c:196:
> > +^I^Ilen = snprintf(&ptr[4], sizeof(data) - used - 4, "%s", tcmu_dev_get_cfgstring(dev));$
> > 
> > ERROR: code indent should never use tabs
> > #706: FILE: tcmu/helper.c:197:
> > +^I^Iptr[3] = len + 1;$
> > 
> > ERROR: code indent should never use tabs
> > #708: FILE: tcmu/helper.c:199:
> > +^I^Iused += (uint8_t)ptr[3] + 4;$
> > 
> > ERROR: code indent should never use tabs
> > #709: FILE: tcmu/helper.c:200:
> > +^I^Iptr += (uint8_t)ptr[3] + 4;$
> > 
> > ERROR: code indent should never use tabs
> > #711: FILE: tcmu/helper.c:202:
> > +^I^I/* Done with descriptor list */$
> > 
> > ERROR: code indent should never use tabs
> > #713: FILE: tcmu/helper.c:204:
> > +^I^I*tot_len = htobe16(used);$
> > 
> > ERROR: code indent should never use tabs
> > #715: FILE: tcmu/helper.c:206:
> > +^I^Itcmu_memcpy_into_iovec(iovec, iov_cnt, data, used + 4);$
> > 
> > ERROR: code indent should never use tabs
> > #717: FILE: tcmu/helper.c:208:
> > +^I^Ifree(wwn);$
> > 
> > ERROR: code indent should never use tabs
> > #718: FILE: tcmu/helper.c:209:
> > +^I^Iwwn = NULL;$
> > 
> > ERROR: code indent should never use tabs
> > #720: FILE: tcmu/helper.c:211:
> > +^I^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #721: FILE: tcmu/helper.c:212:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #722: FILE: tcmu/helper.c:213:
> > +^Ibreak;$
> > 
> > ERROR: code indent should never use tabs
> > #723: FILE: tcmu/helper.c:214:
> > +^Icase 0xb0: /* Block Limits */$
> > 
> > ERROR: code indent should never use tabs
> > #724: FILE: tcmu/helper.c:215:
> > +^I{$
> > 
> > ERROR: code indent should never use tabs
> > #725: FILE: tcmu/helper.c:216:
> > +^I^Ichar data[64];$
> > 
> > ERROR: code indent should never use tabs
> > #726: FILE: tcmu/helper.c:217:
> > +^I^Iuint32_t max_xfer_length;$
> > 
> > ERROR: code indent should never use tabs
> > #727: FILE: tcmu/helper.c:218:
> > +^I^Iuint16_t val16;$
> > 
> > ERROR: code indent should never use tabs
> > #728: FILE: tcmu/helper.c:219:
> > +^I^Iuint32_t val32;$
> > 
> > ERROR: code indent should never use tabs
> > #730: FILE: tcmu/helper.c:221:
> > +^I^Imemset(data, 0, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #732: FILE: tcmu/helper.c:223:
> > +^I^Idata[1] = 0xb0;$
> > 
> > ERROR: code indent should never use tabs
> > #734: FILE: tcmu/helper.c:225:
> > +^I^Ival16 = htobe16(0x3c);$
> > 
> > ERROR: code indent should never use tabs
> > #735: FILE: tcmu/helper.c:226:
> > +^I^Imemcpy(&data[2], &val16, 2);$
> > 
> > ERROR: code indent should never use tabs
> > #737: FILE: tcmu/helper.c:228:
> > +^I^I/* WSNZ = 1: the device server won't support a value of zero$
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #737: FILE: tcmu/helper.c:228:
> > +               /* WSNZ = 1: the device server won't support a value of zero
> > 
> > ERROR: code indent should never use tabs
> > #738: FILE: tcmu/helper.c:229:
> > +^I^I * in the NUMBER OF LOGICAL BLOCKS field in the WRITE SAME$
> > 
> > ERROR: code indent should never use tabs
> > #739: FILE: tcmu/helper.c:230:
> > +^I^I * command CDBs$
> > 
> > ERROR: code indent should never use tabs
> > #740: FILE: tcmu/helper.c:231:
> > +^I^I */$
> > 
> > ERROR: code indent should never use tabs
> > #741: FILE: tcmu/helper.c:232:
> > +^I^Idata[4] = 0x01;$
> > 
> > ERROR: code indent should never use tabs
> > #743: FILE: tcmu/helper.c:234:
> > +^I^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #744: FILE: tcmu/helper.c:235:
> > +^I^I * Daemons like runner may override the user requested$
> > 
> > ERROR: code indent should never use tabs
> > #745: FILE: tcmu/helper.c:236:
> > +^I^I * value due to device specific limits.$
> > 
> > ERROR: code indent should never use tabs
> > #746: FILE: tcmu/helper.c:237:
> > +^I^I */$
> > 
> > ERROR: code indent should never use tabs
> > #747: FILE: tcmu/helper.c:238:
> > +^I^Imax_xfer_length = tcmu_dev_get_max_xfer_len(dev);$
> > 
> > ERROR: code indent should never use tabs
> > #749: FILE: tcmu/helper.c:240:
> > +^I^Ival32 = htobe32(max_xfer_length);$
> > 
> > ERROR: code indent should never use tabs
> > #750: FILE: tcmu/helper.c:241:
> > +^I^I/* Max xfer length */$
> > 
> > ERROR: code indent should never use tabs
> > #751: FILE: tcmu/helper.c:242:
> > +^I^Imemcpy(&data[8], &val32, 4);$
> > 
> > ERROR: code indent should never use tabs
> > #752: FILE: tcmu/helper.c:243:
> > +^I^I/* Optimal xfer length */$
> > 
> > ERROR: code indent should never use tabs
> > #753: FILE: tcmu/helper.c:244:
> > +^I^Imemcpy(&data[12], &val32, 4);$
> > 
> > ERROR: code indent should never use tabs
> > #755: FILE: tcmu/helper.c:246:
> > +^I^Itcmu_memcpy_into_iovec(iovec, iov_cnt, data, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #757: FILE: tcmu/helper.c:248:
> > +^I^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #758: FILE: tcmu/helper.c:249:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #759: FILE: tcmu/helper.c:250:
> > +^Ibreak;$
> > 
> > ERROR: code indent should never use tabs
> > #760: FILE: tcmu/helper.c:251:
> > +^Icase 0xb1: /* Block Device Characteristics VPD page */$
> > 
> > ERROR: code indent should never use tabs
> > #761: FILE: tcmu/helper.c:252:
> > +^I{$
> > 
> > ERROR: code indent should never use tabs
> > #762: FILE: tcmu/helper.c:253:
> > +^I^Ichar data[64];$
> > 
> > ERROR: code indent should never use tabs
> > #763: FILE: tcmu/helper.c:254:
> > +^I^Iuint16_t val16;$
> > 
> > ERROR: code indent should never use tabs
> > #765: FILE: tcmu/helper.c:256:
> > +^I^Imemset(data, 0, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #767: FILE: tcmu/helper.c:258:
> > +^I^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #768: FILE: tcmu/helper.c:259:
> > +^I^I * From spc-5 Revision 14, section 6.7.2 Standard INQUIRY data$
> > 
> > ERROR: code indent should never use tabs
> > #769: FILE: tcmu/helper.c:260:
> > +^I^I * set the devive type to Direct access block device.$
> > 
> > ERROR: code indent should never use tabs
> > #770: FILE: tcmu/helper.c:261:
> > +^I^I */$
> > 
> > ERROR: code indent should never use tabs
> > #771: FILE: tcmu/helper.c:262:
> > +^I^Idata[0] = 0x00;$
> > 
> > ERROR: code indent should never use tabs
> > #773: FILE: tcmu/helper.c:264:
> > +^I^I/* PAGE CODE (B1h) */$
> > 
> > ERROR: code indent should never use tabs
> > #774: FILE: tcmu/helper.c:265:
> > +^I^Idata[1] = 0xb1;$
> > 
> > ERROR: code indent should never use tabs
> > #776: FILE: tcmu/helper.c:267:
> > +^I^I/* PAGE LENGTH (003Ch)*/$
> > 
> > ERROR: code indent should never use tabs
> > #777: FILE: tcmu/helper.c:268:
> > +^I^Ival16 = htobe16(0x003c);$
> > 
> > ERROR: code indent should never use tabs
> > #778: FILE: tcmu/helper.c:269:
> > +^I^Imemcpy(&data[2], &val16, 2);$
> > 
> > ERROR: code indent should never use tabs
> > #780: FILE: tcmu/helper.c:271:
> > +^I^Iif (tcmu_dev_get_solid_state_media(dev)) {$
> > 
> > ERROR: code indent should never use tabs
> > #781: FILE: tcmu/helper.c:272:
> > +^I^I^Ival16 = htobe16(0x0001);$
> > 
> > ERROR: code indent should never use tabs
> > #782: FILE: tcmu/helper.c:273:
> > +^I^I^Imemcpy(&data[4], &val16, 2);$
> > 
> > ERROR: code indent should never use tabs
> > #783: FILE: tcmu/helper.c:274:
> > +^I^I}$
> > 
> > ERROR: code indent should never use tabs
> > #785: FILE: tcmu/helper.c:276:
> > +^I^Itcmu_memcpy_into_iovec(iovec, iov_cnt, data, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #786: FILE: tcmu/helper.c:277:
> > +^I^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #787: FILE: tcmu/helper.c:278:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #788: FILE: tcmu/helper.c:279:
> > +^Ibreak;$
> > 
> > ERROR: code indent should never use tabs
> > #789: FILE: tcmu/helper.c:280:
> > +^Icase 0xb2: /* Logical Block Provisioning VPD page */$
> > 
> > ERROR: code indent should never use tabs
> > #790: FILE: tcmu/helper.c:281:
> > +^I{$
> > 
> > ERROR: code indent should never use tabs
> > #791: FILE: tcmu/helper.c:282:
> > +^I^Ichar data[64];$
> > 
> > ERROR: code indent should never use tabs
> > #792: FILE: tcmu/helper.c:283:
> > +^I^Iuint16_t val16;$
> > 
> > ERROR: code indent should never use tabs
> > #794: FILE: tcmu/helper.c:285:
> > +^I^Imemset(data, 0, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #796: FILE: tcmu/helper.c:287:
> > +^I^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #797: FILE: tcmu/helper.c:288:
> > +^I^I * From spc-5 Revision 14, section 6.7.2 Standard INQUIRY data$
> > 
> > ERROR: code indent should never use tabs
> > #798: FILE: tcmu/helper.c:289:
> > +^I^I * set the device type to Direct access block device.$
> > 
> > ERROR: code indent should never use tabs
> > #799: FILE: tcmu/helper.c:290:
> > +^I^I */$
> > 
> > ERROR: code indent should never use tabs
> > #800: FILE: tcmu/helper.c:291:
> > +^I^Idata[0] = 0x00;$
> > 
> > ERROR: code indent should never use tabs
> > #802: FILE: tcmu/helper.c:293:
> > +^I^I/* PAGE CODE (B2h) */$
> > 
> > ERROR: code indent should never use tabs
> > #803: FILE: tcmu/helper.c:294:
> > +^I^Idata[1] = 0xb2;$
> > 
> > ERROR: code indent should never use tabs
> > #805: FILE: tcmu/helper.c:296:
> > +^I^I/*$
> > 
> > WARNING: line over 80 characters
> > #806: FILE: tcmu/helper.c:297:
> > +                * PAGE LENGTH field: PROVISIONING GROUP DESCRIPTOR field will be
> > 
> > ERROR: code indent should never use tabs
> > #806: FILE: tcmu/helper.c:297:
> > +^I^I * PAGE LENGTH field: PROVISIONING GROUP DESCRIPTOR field will be$
> > 
> > ERROR: code indent should never use tabs
> > #807: FILE: tcmu/helper.c:298:
> > +^I^I * not present.$
> > 
> > ERROR: code indent should never use tabs
> > #808: FILE: tcmu/helper.c:299:
> > +^I^I */$
> > 
> > ERROR: code indent should never use tabs
> > #809: FILE: tcmu/helper.c:300:
> > +^I^Ival16 = htobe16(0x0004);$
> > 
> > ERROR: code indent should never use tabs
> > #810: FILE: tcmu/helper.c:301:
> > +^I^Imemcpy(&data[2], &val16, 2);$
> > 
> > ERROR: code indent should never use tabs
> > #812: FILE: tcmu/helper.c:303:
> > +^I^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #813: FILE: tcmu/helper.c:304:
> > +^I^I * The logical block provisioning read zeros (LBPRZ) field.$
> > 
> > ERROR: code indent should never use tabs
> > #814: FILE: tcmu/helper.c:305:
> > +^I^I *$
> > 
> > WARNING: line over 80 characters
> > #815: FILE: tcmu/helper.c:306:
> > +                * The logical block data represented by unmapped LBAs is set to zeros
> > 
> > ERROR: code indent should never use tabs
> > #815: FILE: tcmu/helper.c:306:
> > +^I^I * The logical block data represented by unmapped LBAs is set to zeros$
> > 
> > ERROR: code indent should never use tabs
> > #816: FILE: tcmu/helper.c:307:
> > +^I^I */$
> > 
> > ERROR: code indent should never use tabs
> > #817: FILE: tcmu/helper.c:308:
> > +^I^Idata[5] = 0x04;$
> > 
> > ERROR: code indent should never use tabs
> > #819: FILE: tcmu/helper.c:310:
> > +^I^Itcmu_memcpy_into_iovec(iovec, iov_cnt, data, sizeof(data));$
> > 
> > ERROR: code indent should never use tabs
> > #820: FILE: tcmu/helper.c:311:
> > +^I^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #821: FILE: tcmu/helper.c:312:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #822: FILE: tcmu/helper.c:313:
> > +^Ibreak;$
> > 
> > ERROR: code indent should never use tabs
> > #823: FILE: tcmu/helper.c:314:
> > +^Idefault:$
> > 
> > ERROR: code indent should never use tabs
> > #824: FILE: tcmu/helper.c:315:
> > +^I^Ierror_report("Vital product data page code 0x%x not support\n",$
> > 
> > ERROR: Error messages should not contain newlines
> > #824: FILE: tcmu/helper.c:315:
> > +               error_report("Vital product data page code 0x%x not support\n",
> > 
> > ERROR: code indent should never use tabs
> > #825: FILE: tcmu/helper.c:316:
> > +^I^I^I     cdb[2]);$
> > 
> > ERROR: code indent should never use tabs
> > #826: FILE: tcmu/helper.c:317:
> > +^I^Ireturn TCMU_STS_INVALID_CDB;$
> > 
> > ERROR: code indent should never use tabs
> > #827: FILE: tcmu/helper.c:318:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #834: FILE: tcmu/helper.c:325:
> > +^Istruct tcmu_device *dev,$
> > 
> > ERROR: code indent should never use tabs
> > #835: FILE: tcmu/helper.c:326:
> > +^Iuint8_t *cdb,$
> > 
> > ERROR: code indent should never use tabs
> > #836: FILE: tcmu/helper.c:327:
> > +^Istruct iovec *iovec,$
> > 
> > ERROR: code indent should never use tabs
> > #837: FILE: tcmu/helper.c:328:
> > +^Isize_t iov_cnt)$
> > 
> > ERROR: code indent should never use tabs
> > #839: FILE: tcmu/helper.c:330:
> > +^Iif (!(cdb[1] & 0x01)) {$
> > 
> > ERROR: code indent should never use tabs
> > #840: FILE: tcmu/helper.c:331:
> > +^I^Iif (!cdb[2])$
> > 
> > ERROR: code indent should never use tabs
> > #841: FILE: tcmu/helper.c:332:
> > +^I^I^Ireturn tcmu_emulate_std_inquiry(cdb, iovec,$
> > 
> > ERROR: code indent should never use tabs
> > #842: FILE: tcmu/helper.c:333:
> > +^I^I^I^I^I^I^Iiov_cnt);$
> > 
> > ERROR: code indent should never use tabs
> > #843: FILE: tcmu/helper.c:334:
> > +^I^Ielse$
> > 
> > ERROR: code indent should never use tabs
> > #844: FILE: tcmu/helper.c:335:
> > +^I^I^Ireturn TCMU_STS_INVALID_CDB;$
> > 
> > ERROR: code indent should never use tabs
> > #845: FILE: tcmu/helper.c:336:
> > +^I} else {$
> > 
> > ERROR: code indent should never use tabs
> > #846: FILE: tcmu/helper.c:337:
> > +^I^Ireturn tcmu_emulate_evpd_inquiry(dev, cdb, iovec, iov_cnt);$
> > 
> > ERROR: code indent should never use tabs
> > #847: FILE: tcmu/helper.c:338:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #851: FILE: tcmu/helper.c:342:
> > +^Iuint8_t *cdb,$
> > 
> > ERROR: code indent should never use tabs
> > #852: FILE: tcmu/helper.c:343:
> > +^Istruct iovec *iovec,$
> > 
> > ERROR: code indent should never use tabs
> > #853: FILE: tcmu/helper.c:344:
> > +^Isize_t iov_cnt)$
> > 
> > ERROR: code indent should never use tabs
> > #855: FILE: tcmu/helper.c:346:
> > +^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #859: FILE: tcmu/helper.c:350:
> > +^Iuint64_t num_lbas,$
> > 
> > ERROR: code indent should never use tabs
> > #860: FILE: tcmu/helper.c:351:
> > +^Iuint32_t block_size,$
> > 
> > ERROR: code indent should never use tabs
> > #861: FILE: tcmu/helper.c:352:
> > +^Iuint8_t *cdb,$
> > 
> > ERROR: code indent should never use tabs
> > #862: FILE: tcmu/helper.c:353:
> > +^Istruct iovec *iovec,$
> > 
> > ERROR: code indent should never use tabs
> > #863: FILE: tcmu/helper.c:354:
> > +^Isize_t iov_cnt)$
> > 
> > ERROR: code indent should never use tabs
> > #865: FILE: tcmu/helper.c:356:
> > +^Iuint8_t buf[8];$
> > 
> > ERROR: code indent should never use tabs
> > #866: FILE: tcmu/helper.c:357:
> > +^Iuint32_t val32;$
> > 
> > ERROR: code indent should never use tabs
> > #868: FILE: tcmu/helper.c:359:
> > +^Imemset(buf, 0, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #870: FILE: tcmu/helper.c:361:
> > +^Iif (num_lbas < 0x100000000ULL) {$
> > 
> > ERROR: code indent should never use tabs
> > #871: FILE: tcmu/helper.c:362:
> > +^I^I// Return the LBA of the last logical block, so subtract 1.$
> > 
> > ERROR: do not use C99 // comments
> > #871: FILE: tcmu/helper.c:362:
> > +               // Return the LBA of the last logical block, so subtract 1.
> > 
> > ERROR: code indent should never use tabs
> > #872: FILE: tcmu/helper.c:363:
> > +^I^Ival32 = htobe32(num_lbas-1);$
> > 
> > ERROR: spaces required around that '-' (ctx:VxV)
> > #872: FILE: tcmu/helper.c:363:
> > +               val32 = htobe32(num_lbas-1);
> >                                         ^
> > 
> > ERROR: code indent should never use tabs
> > #873: FILE: tcmu/helper.c:364:
> > +^I} else {$
> > 
> > ERROR: code indent should never use tabs
> > #874: FILE: tcmu/helper.c:365:
> > +^I^I// This lets the initiator know that he needs to use$
> > 
> > ERROR: do not use C99 // comments
> > #874: FILE: tcmu/helper.c:365:
> > +               // This lets the initiator know that he needs to use
> > 
> > ERROR: code indent should never use tabs
> > #875: FILE: tcmu/helper.c:366:
> > +^I^I// Read Capacity(16).$
> > 
> > ERROR: do not use C99 // comments
> > #875: FILE: tcmu/helper.c:366:
> > +               // Read Capacity(16).
> > 
> > ERROR: code indent should never use tabs
> > #876: FILE: tcmu/helper.c:367:
> > +^I^Ival32 = 0xffffffff;$
> > 
> > ERROR: code indent should never use tabs
> > #877: FILE: tcmu/helper.c:368:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #879: FILE: tcmu/helper.c:370:
> > +^Imemcpy(&buf[0], &val32, 4);$
> > 
> > ERROR: code indent should never use tabs
> > #881: FILE: tcmu/helper.c:372:
> > +^Ival32 = htobe32(block_size);$
> > 
> > ERROR: code indent should never use tabs
> > #882: FILE: tcmu/helper.c:373:
> > +^Imemcpy(&buf[4], &val32, 4);$
> > 
> > ERROR: code indent should never use tabs
> > #884: FILE: tcmu/helper.c:375:
> > +^I/* all else is zero */$
> > 
> > ERROR: code indent should never use tabs
> > #886: FILE: tcmu/helper.c:377:
> > +^Itcmu_memcpy_into_iovec(iovec, iov_cnt, buf, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #888: FILE: tcmu/helper.c:379:
> > +^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #892: FILE: tcmu/helper.c:383:
> > +^Iuint64_t num_lbas,$
> > 
> > ERROR: code indent should never use tabs
> > #893: FILE: tcmu/helper.c:384:
> > +^Iuint32_t block_size,$
> > 
> > ERROR: code indent should never use tabs
> > #894: FILE: tcmu/helper.c:385:
> > +^Iuint8_t *cdb,$
> > 
> > ERROR: code indent should never use tabs
> > #895: FILE: tcmu/helper.c:386:
> > +^Istruct iovec *iovec,$
> > 
> > ERROR: code indent should never use tabs
> > #896: FILE: tcmu/helper.c:387:
> > +^Isize_t iov_cnt)$
> > 
> > ERROR: code indent should never use tabs
> > #898: FILE: tcmu/helper.c:389:
> > +^Iuint8_t buf[32];$
> > 
> > ERROR: code indent should never use tabs
> > #899: FILE: tcmu/helper.c:390:
> > +^Iuint64_t val64;$
> > 
> > ERROR: code indent should never use tabs
> > #900: FILE: tcmu/helper.c:391:
> > +^Iuint32_t val32;$
> > 
> > ERROR: code indent should never use tabs
> > #902: FILE: tcmu/helper.c:393:
> > +^Imemset(buf, 0, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #904: FILE: tcmu/helper.c:395:
> > +^I// Return the LBA of the last logical block, so subtract 1.$
> > 
> > ERROR: do not use C99 // comments
> > #904: FILE: tcmu/helper.c:395:
> > +       // Return the LBA of the last logical block, so subtract 1.
> > 
> > ERROR: code indent should never use tabs
> > #905: FILE: tcmu/helper.c:396:
> > +^Ival64 = htobe64(num_lbas-1);$
> > 
> > ERROR: spaces required around that '-' (ctx:VxV)
> > #905: FILE: tcmu/helper.c:396:
> > +       val64 = htobe64(num_lbas-1);
> >                                 ^
> > 
> > ERROR: code indent should never use tabs
> > #906: FILE: tcmu/helper.c:397:
> > +^Imemcpy(&buf[0], &val64, 8);$
> > 
> > ERROR: code indent should never use tabs
> > #908: FILE: tcmu/helper.c:399:
> > +^Ival32 = htobe32(block_size);$
> > 
> > ERROR: code indent should never use tabs
> > #909: FILE: tcmu/helper.c:400:
> > +^Imemcpy(&buf[8], &val32, 4);$
> > 
> > ERROR: code indent should never use tabs
> > #911: FILE: tcmu/helper.c:402:
> > +^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #912: FILE: tcmu/helper.c:403:
> > +^I * Logical Block Provisioning Management Enabled (LBPME) bit$
> > 
> > ERROR: code indent should never use tabs
> > #913: FILE: tcmu/helper.c:404:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #914: FILE: tcmu/helper.c:405:
> > +^I * The LBPME bit sets to one and then the logical unit implements$
> > 
> > ERROR: code indent should never use tabs
> > #915: FILE: tcmu/helper.c:406:
> > +^I * logical block provisioning management$
> > 
> > ERROR: code indent should never use tabs
> > #916: FILE: tcmu/helper.c:407:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #917: FILE: tcmu/helper.c:408:
> > +^Ibuf[14] = 0x80;$
> > 
> > ERROR: code indent should never use tabs
> > #919: FILE: tcmu/helper.c:410:
> > +^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #920: FILE: tcmu/helper.c:411:
> > +^I * The logical block provisioning read zeros (LBPRZ) bit shall be$
> > 
> > ERROR: code indent should never use tabs
> > #921: FILE: tcmu/helper.c:412:
> > +^I * set to one if the LBPRZ field is set to xx1b in VPD B2. The$
> > 
> > ERROR: code indent should never use tabs
> > #922: FILE: tcmu/helper.c:413:
> > +^I * LBPRZ bit shall be set to zero if the LBPRZ field is not set$
> > 
> > ERROR: code indent should never use tabs
> > #923: FILE: tcmu/helper.c:414:
> > +^I * to xx1b.$
> > 
> > ERROR: code indent should never use tabs
> > #924: FILE: tcmu/helper.c:415:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #925: FILE: tcmu/helper.c:416:
> > +^Ibuf[14] |= 0x40;$
> > 
> > ERROR: code indent should never use tabs
> > #927: FILE: tcmu/helper.c:418:
> > +^I/* all else is zero */$
> > 
> > ERROR: code indent should never use tabs
> > #929: FILE: tcmu/helper.c:420:
> > +^Itcmu_memcpy_into_iovec(iovec, iov_cnt, buf, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #931: FILE: tcmu/helper.c:422:
> > +^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #935: FILE: tcmu/helper.c:426:
> > +^I^I^I^I uint8_t *from_buf, size_t from_len)$
> > 
> > ERROR: code indent should never use tabs
> > #937: FILE: tcmu/helper.c:428:
> > +^Iif (!to_buf)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #937: FILE: tcmu/helper.c:428:
> > +       if (!to_buf)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #938: FILE: tcmu/helper.c:429:
> > +^I^Ireturn;$
> > 
> > ERROR: code indent should never use tabs
> > #939: FILE: tcmu/helper.c:430:
> > +^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #940: FILE: tcmu/helper.c:431:
> > +^I * SPC 4r37: 4.3.5.6 Allocation length:$
> > 
> > ERROR: code indent should never use tabs
> > #941: FILE: tcmu/helper.c:432:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #942: FILE: tcmu/helper.c:433:
> > +^I * The device server shall terminate transfers to the Data-In Buffer$
> > 
> > ERROR: code indent should never use tabs
> > #943: FILE: tcmu/helper.c:434:
> > +^I * when the number of bytes or blocks specified by the ALLOCATION$
> > 
> > ERROR: code indent should never use tabs
> > #944: FILE: tcmu/helper.c:435:
> > +^I * LENGTH field have been transferred or when all available data$
> > 
> > ERROR: code indent should never use tabs
> > #945: FILE: tcmu/helper.c:436:
> > +^I * have been transferred, whichever is less.$
> > 
> > ERROR: code indent should never use tabs
> > #946: FILE: tcmu/helper.c:437:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #947: FILE: tcmu/helper.c:438:
> > +^Imemcpy(to_buf, from_buf, to_len > from_len ? from_len : to_len);$
> > 
> > ERROR: code indent should never use tabs
> > #951: FILE: tcmu/helper.c:442:
> > +^I^I^I   size_t ret_buf_len)$
> > 
> > ERROR: code indent should never use tabs
> > #953: FILE: tcmu/helper.c:444:
> > +^Iuint8_t buf[12];$
> > 
> > ERROR: code indent should never use tabs
> > #955: FILE: tcmu/helper.c:446:
> > +^Imemset(buf, 0, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #956: FILE: tcmu/helper.c:447:
> > +^Ibuf[0] = 0x1;$
> > 
> > ERROR: code indent should never use tabs
> > #957: FILE: tcmu/helper.c:448:
> > +^Ibuf[1] = 0xa;$
> > 
> > ERROR: code indent should never use tabs
> > #959: FILE: tcmu/helper.c:450:
> > +^Icopy_to_response_buf(ret_buf, ret_buf_len, buf, 12);$
> > 
> > ERROR: code indent should never use tabs
> > #960: FILE: tcmu/helper.c:451:
> > +^Ireturn 12;$
> > 
> > ERROR: code indent should never use tabs
> > #964: FILE: tcmu/helper.c:455:
> > +^I^I      size_t ret_buf_len)$
> > 
> > ERROR: code indent should never use tabs
> > #966: FILE: tcmu/helper.c:457:
> > +^Iuint8_t buf[20];$
> > 
> > ERROR: code indent should never use tabs
> > #968: FILE: tcmu/helper.c:459:
> > +^Imemset(buf, 0, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #969: FILE: tcmu/helper.c:460:
> > +^Ibuf[0] = 0x8;$
> > 
> > ERROR: code indent should never use tabs
> > #970: FILE: tcmu/helper.c:461:
> > +^Ibuf[1] = 0x12;$
> > 
> > ERROR: code indent should never use tabs
> > #972: FILE: tcmu/helper.c:463:
> > +^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #973: FILE: tcmu/helper.c:464:
> > +^I * If device supports a writeback cache then set writeback$
> > 
> > ERROR: code indent should never use tabs
> > #974: FILE: tcmu/helper.c:465:
> > +^I * cache enable (WCE)$
> > 
> > ERROR: code indent should never use tabs
> > #975: FILE: tcmu/helper.c:466:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #976: FILE: tcmu/helper.c:467:
> > +^Iif (tcmu_dev_get_write_cache_enabled(dev))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #976: FILE: tcmu/helper.c:467:
> > +       if (tcmu_dev_get_write_cache_enabled(dev))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #977: FILE: tcmu/helper.c:468:
> > +^I^Ibuf[2] = 0x4;$
> > 
> > ERROR: code indent should never use tabs
> > #979: FILE: tcmu/helper.c:470:
> > +^Icopy_to_response_buf(ret_buf, ret_buf_len, buf, 20);$
> > 
> > ERROR: code indent should never use tabs
> > #980: FILE: tcmu/helper.c:471:
> > +^Ireturn 20;$
> > 
> > ERROR: code indent should never use tabs
> > #984: FILE: tcmu/helper.c:475:
> > +^I^I^I       size_t ret_buf_len)$
> > 
> > ERROR: code indent should never use tabs
> > #986: FILE: tcmu/helper.c:477:
> > +^Iuint8_t buf[12];$
> > 
> > ERROR: code indent should never use tabs
> > #988: FILE: tcmu/helper.c:479:
> > +^Imemset(buf, 0, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #989: FILE: tcmu/helper.c:480:
> > +^Ibuf[0] = 0x0a;$
> > 
> > ERROR: code indent should never use tabs
> > #990: FILE: tcmu/helper.c:481:
> > +^Ibuf[1] = 0x0a;$
> > 
> > ERROR: code indent should never use tabs
> > #992: FILE: tcmu/helper.c:483:
> > +^I/* From spc4r31, section 7.5.7 Control mode Page$
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #992: FILE: tcmu/helper.c:483:
> > +       /* From spc4r31, section 7.5.7 Control mode Page
> > 
> > ERROR: code indent should never use tabs
> > #993: FILE: tcmu/helper.c:484:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #994: FILE: tcmu/helper.c:485:
> > +^I * GLTSD = 1: because we don't implicitly save log parameters$
> > 
> > ERROR: code indent should never use tabs
> > #995: FILE: tcmu/helper.c:486:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #996: FILE: tcmu/helper.c:487:
> > +^I * A global logging target save disable (GLTSD) bit set to$
> > 
> > ERROR: code indent should never use tabs
> > #997: FILE: tcmu/helper.c:488:
> > +^I * zero specifies that the logical unit implicitly saves, at$
> > 
> > ERROR: code indent should never use tabs
> > #998: FILE: tcmu/helper.c:489:
> > +^I * vendor specific intervals, each log parameter in which the$
> > 
> > ERROR: code indent should never use tabs
> > #999: FILE: tcmu/helper.c:490:
> > +^I * TSD bit (see 7.3) is set to zero. A GLTSD bit set to one$
> > 
> > ERROR: code indent should never use tabs
> > #1000: FILE: tcmu/helper.c:491:
> > +^I * specifies that the logical unit shall not implicitly save$
> > 
> > ERROR: code indent should never use tabs
> > #1001: FILE: tcmu/helper.c:492:
> > +^I * any log parameters.$
> > 
> > ERROR: code indent should never use tabs
> > #1002: FILE: tcmu/helper.c:493:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #1003: FILE: tcmu/helper.c:494:
> > +^Ibuf[2] = 0x02;$
> > 
> > ERROR: code indent should never use tabs
> > #1005: FILE: tcmu/helper.c:496:
> > +^I/* From spc4r31, section 7.5.7 Control mode Page$
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #1005: FILE: tcmu/helper.c:496:
> > +       /* From spc4r31, section 7.5.7 Control mode Page
> > 
> > ERROR: code indent should never use tabs
> > #1006: FILE: tcmu/helper.c:497:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #1007: FILE: tcmu/helper.c:498:
> > +^I * TAS = 1: Currently not settable by tcmu. Using the LIO default$
> > 
> > ERROR: code indent should never use tabs
> > #1008: FILE: tcmu/helper.c:499:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #1009: FILE: tcmu/helper.c:500:
> > +^I * A task aborted status (TAS) bit set to zero specifies that$
> > 
> > ERROR: code indent should never use tabs
> > #1010: FILE: tcmu/helper.c:501:
> > +^I * aborted commands shall be terminated by the device server$
> > 
> > ERROR: code indent should never use tabs
> > #1011: FILE: tcmu/helper.c:502:
> > +^I * without any response to the application client. A TAS bit$
> > 
> > ERROR: code indent should never use tabs
> > #1012: FILE: tcmu/helper.c:503:
> > +^I * set to one specifies that commands aborted by the actions$
> > 
> > ERROR: code indent should never use tabs
> > #1013: FILE: tcmu/helper.c:504:
> > +^I * of an I_T nexus other than the I_T nexus on which the command$
> > 
> > ERROR: code indent should never use tabs
> > #1014: FILE: tcmu/helper.c:505:
> > +^I * was received shall be completed with TASK ABORTED status$
> > 
> > ERROR: code indent should never use tabs
> > #1015: FILE: tcmu/helper.c:506:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #1016: FILE: tcmu/helper.c:507:
> > +^Ibuf[5] = 0x40;$
> > 
> > ERROR: code indent should never use tabs
> > #1018: FILE: tcmu/helper.c:509:
> > +^I/* From spc4r31, section 7.5.7 Control mode Page$
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #1018: FILE: tcmu/helper.c:509:
> > +       /* From spc4r31, section 7.5.7 Control mode Page
> > 
> > ERROR: code indent should never use tabs
> > #1019: FILE: tcmu/helper.c:510:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #1020: FILE: tcmu/helper.c:511:
> > +^I * BUSY TIMEOUT PERIOD: Currently is unlimited$
> > 
> > ERROR: code indent should never use tabs
> > #1021: FILE: tcmu/helper.c:512:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #1022: FILE: tcmu/helper.c:513:
> > +^I * The BUSY TIMEOUT PERIOD field specifies the maximum time, in$
> > 
> > ERROR: code indent should never use tabs
> > #1023: FILE: tcmu/helper.c:514:
> > +^I * 100 milliseconds increments, that the application client allows$
> > 
> > ERROR: code indent should never use tabs
> > #1024: FILE: tcmu/helper.c:515:
> > +^I * for the device server to return BUSY status for unanticipated$
> > 
> > ERROR: code indent should never use tabs
> > #1025: FILE: tcmu/helper.c:516:
> > +^I * conditions that are not a routine part of commands from the$
> > 
> > ERROR: code indent should never use tabs
> > #1026: FILE: tcmu/helper.c:517:
> > +^I * application client. This value may be rounded down as defined$
> > 
> > ERROR: code indent should never use tabs
> > #1027: FILE: tcmu/helper.c:518:
> > +^I * in 5.4(the Parameter rounding section).$
> > 
> > ERROR: code indent should never use tabs
> > #1028: FILE: tcmu/helper.c:519:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #1029: FILE: tcmu/helper.c:520:
> > +^I * A 0000h value in this field is undefined by this standard.$
> > 
> > ERROR: code indent should never use tabs
> > #1030: FILE: tcmu/helper.c:521:
> > +^I * An FFFFh value in this field is defined as an unlimited period.$
> > 
> > ERROR: code indent should never use tabs
> > #1031: FILE: tcmu/helper.c:522:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #1032: FILE: tcmu/helper.c:523:
> > +^Ibuf[8] = 0xff;$
> > 
> > ERROR: code indent should never use tabs
> > #1033: FILE: tcmu/helper.c:524:
> > +^Ibuf[9] = 0xff;$
> > 
> > ERROR: code indent should never use tabs
> > #1035: FILE: tcmu/helper.c:526:
> > +^Icopy_to_response_buf(ret_buf, ret_buf_len, buf, 12);$
> > 
> > ERROR: code indent should never use tabs
> > #1036: FILE: tcmu/helper.c:527:
> > +^Ireturn 12;$
> > 
> > ERROR: code indent should never use tabs
> > #1041: FILE: tcmu/helper.c:532:
> > +^Iuint8_t page;$
> > 
> > ERROR: code indent should never use tabs
> > #1042: FILE: tcmu/helper.c:533:
> > +^Iuint8_t subpage;$
> > 
> > ERROR: code indent should never use tabs
> > #1043: FILE: tcmu/helper.c:534:
> > +^Iint (*get)(struct tcmu_device *dev, uint8_t *buf, size_t buf_len);$
> > 
> > ERROR: code indent should never use tabs
> > #1045: FILE: tcmu/helper.c:536:
> > +^I{0x1, 0, handle_rwrecovery_page},$
> > 
> > ERROR: code indent should never use tabs
> > #1046: FILE: tcmu/helper.c:537:
> > +^I{0x8, 0, handle_cache_page},$
> > 
> > ERROR: code indent should never use tabs
> > #1047: FILE: tcmu/helper.c:538:
> > +^I{0xa, 0, handle_control_page},$
> > 
> > ERROR: code indent should never use tabs
> > #1051: FILE: tcmu/helper.c:542:
> > +^I^I^I^I struct mode_sense_handler *handler,$
> > 
> > ERROR: code indent should never use tabs
> > #1052: FILE: tcmu/helper.c:543:
> > +^I^I^I^I uint8_t **buf, size_t alloc_len,$
> > 
> > ERROR: code indent should never use tabs
> > #1053: FILE: tcmu/helper.c:544:
> > +^I^I^I^I size_t *used_len, bool sense_ten)$
> > 
> > ERROR: code indent should never use tabs
> > #1055: FILE: tcmu/helper.c:546:
> > +^Iint ret;$
> > 
> > ERROR: code indent should never use tabs
> > #1057: FILE: tcmu/helper.c:548:
> > +^Iret = handler->get(dev, *buf, alloc_len - *used_len);$
> > 
> > ERROR: code indent should never use tabs
> > #1059: FILE: tcmu/helper.c:550:
> > +^Iif  (!sense_ten && (*used_len + ret >= 255))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1059: FILE: tcmu/helper.c:550:
> > +       if  (!sense_ten && (*used_len + ret >= 255))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1060: FILE: tcmu/helper.c:551:
> > +^I^Ireturn -EINVAL;$
> > 
> > ERROR: code indent should never use tabs
> > #1062: FILE: tcmu/helper.c:553:
> > +^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #1063: FILE: tcmu/helper.c:554:
> > +^I * SPC 4r37: 4.3.5.6 Allocation length:$
> > 
> > ERROR: code indent should never use tabs
> > #1064: FILE: tcmu/helper.c:555:
> > +^I *$
> > 
> > ERROR: code indent should never use tabs
> > #1065: FILE: tcmu/helper.c:556:
> > +^I * If the information being transferred to the Data-In Buffer includes$
> > 
> > ERROR: code indent should never use tabs
> > #1066: FILE: tcmu/helper.c:557:
> > +^I * fields containing counts of the number of bytes in some or all of$
> > 
> > ERROR: code indent should never use tabs
> > #1067: FILE: tcmu/helper.c:558:
> > +^I * the data (e.g., the PARAMETER DATA LENGTH field, the PAGE LENGTH$
> > 
> > ERROR: code indent should never use tabs
> > #1068: FILE: tcmu/helper.c:559:
> > +^I * field, the DESCRIPTOR LENGTH field, the AVAILABLE DATA field),$
> > 
> > ERROR: code indent should never use tabs
> > #1069: FILE: tcmu/helper.c:560:
> > +^I * then the contents of these fields shall not be altered to reflect$
> > 
> > ERROR: code indent should never use tabs
> > #1070: FILE: tcmu/helper.c:561:
> > +^I * the truncation, if any, that results from an insufficient$
> > 
> > ERROR: code indent should never use tabs
> > #1071: FILE: tcmu/helper.c:562:
> > +^I * ALLOCATION LENGTH value$
> > 
> > ERROR: code indent should never use tabs
> > #1072: FILE: tcmu/helper.c:563:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #1073: FILE: tcmu/helper.c:564:
> > +^I/*$
> > 
> > ERROR: code indent should never use tabs
> > #1074: FILE: tcmu/helper.c:565:
> > +^I * Setup the buffer so to still loop over the handlers, but just$
> > 
> > ERROR: code indent should never use tabs
> > #1075: FILE: tcmu/helper.c:566:
> > +^I * increment the used_len so we can return the$
> > 
> > ERROR: code indent should never use tabs
> > #1076: FILE: tcmu/helper.c:567:
> > +^I * final value.$
> > 
> > ERROR: code indent should never use tabs
> > #1077: FILE: tcmu/helper.c:568:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #1078: FILE: tcmu/helper.c:569:
> > +^Iif (*buf && (*used_len + ret >= alloc_len))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1078: FILE: tcmu/helper.c:569:
> > +       if (*buf && (*used_len + ret >= alloc_len))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1079: FILE: tcmu/helper.c:570:
> > +^I^I*buf = NULL;$
> > 
> > ERROR: code indent should never use tabs
> > #1081: FILE: tcmu/helper.c:572:
> > +^I*used_len += ret;$
> > 
> > ERROR: code indent should never use tabs
> > #1082: FILE: tcmu/helper.c:573:
> > +^Iif (*buf)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1082: FILE: tcmu/helper.c:573:
> > +       if (*buf)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1083: FILE: tcmu/helper.c:574:
> > +^I^I*buf += ret;$
> > 
> > ERROR: code indent should never use tabs
> > #1084: FILE: tcmu/helper.c:575:
> > +^Ireturn ret;$
> > 
> > ERROR: code indent should never use tabs
> > #1093: FILE: tcmu/helper.c:584:
> > +^Istruct tcmu_device *dev,$
> > 
> > ERROR: code indent should never use tabs
> > #1094: FILE: tcmu/helper.c:585:
> > +^Iuint8_t *cdb,$
> > 
> > ERROR: code indent should never use tabs
> > #1095: FILE: tcmu/helper.c:586:
> > +^Istruct iovec *iovec,$
> > 
> > ERROR: code indent should never use tabs
> > #1096: FILE: tcmu/helper.c:587:
> > +^Isize_t iov_cnt)$
> > 
> > ERROR: code indent should never use tabs
> > #1098: FILE: tcmu/helper.c:589:
> > +^Ibool sense_ten = (cdb[0] == MODE_SENSE_10);$
> > 
> > ERROR: code indent should never use tabs
> > #1099: FILE: tcmu/helper.c:590:
> > +^Iuint8_t page_code = cdb[2] & 0x3f;$
> > 
> > ERROR: code indent should never use tabs
> > #1100: FILE: tcmu/helper.c:591:
> > +^Iuint8_t subpage_code = cdb[3];$
> > 
> > ERROR: code indent should never use tabs
> > #1101: FILE: tcmu/helper.c:592:
> > +^Isize_t alloc_len = tcmu_dev_get_max_xfer_len(dev);$
> > 
> > ERROR: code indent should never use tabs
> > #1102: FILE: tcmu/helper.c:593:
> > +^Iint i;$
> > 
> > ERROR: code indent should never use tabs
> > #1103: FILE: tcmu/helper.c:594:
> > +^Iint ret;$
> > 
> > ERROR: code indent should never use tabs
> > #1104: FILE: tcmu/helper.c:595:
> > +^Isize_t used_len;$
> > 
> > ERROR: code indent should never use tabs
> > #1105: FILE: tcmu/helper.c:596:
> > +^Iuint8_t *buf;$
> > 
> > ERROR: code indent should never use tabs
> > #1106: FILE: tcmu/helper.c:597:
> > +^Iuint8_t *orig_buf = NULL;$
> > 
> > ERROR: code indent should never use tabs
> > #1108: FILE: tcmu/helper.c:599:
> > +^Iif (!alloc_len)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1108: FILE: tcmu/helper.c:599:
> > +       if (!alloc_len)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1109: FILE: tcmu/helper.c:600:
> > +^I^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #1111: FILE: tcmu/helper.c:602:
> > +^I/* Mode parameter header. Mode data length filled in at the end. */$
> > 
> > ERROR: code indent should never use tabs
> > #1112: FILE: tcmu/helper.c:603:
> > +^Iused_len = sense_ten ? 8 : 4;$
> > 
> > ERROR: code indent should never use tabs
> > #1113: FILE: tcmu/helper.c:604:
> > +^Iif (used_len > alloc_len)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1113: FILE: tcmu/helper.c:604:
> > +       if (used_len > alloc_len)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1114: FILE: tcmu/helper.c:605:
> > +^I^Igoto fail;$
> > 
> > ERROR: code indent should never use tabs
> > #1116: FILE: tcmu/helper.c:607:
> > +^Ibuf = calloc(1, alloc_len);$
> > 
> > ERROR: code indent should never use tabs
> > #1117: FILE: tcmu/helper.c:608:
> > +^Iif (!buf)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1117: FILE: tcmu/helper.c:608:
> > +       if (!buf)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1118: FILE: tcmu/helper.c:609:
> > +^I^Ireturn TCMU_STS_NO_RESOURCE;$
> > 
> > ERROR: code indent should never use tabs
> > #1120: FILE: tcmu/helper.c:611:
> > +^Iorig_buf = buf;$
> > 
> > ERROR: code indent should never use tabs
> > #1121: FILE: tcmu/helper.c:612:
> > +^Ibuf += used_len;$
> > 
> > ERROR: code indent should never use tabs
> > #1123: FILE: tcmu/helper.c:614:
> > +^I/* Don't fill in device-specific parameter */$
> > 
> > ERROR: code indent should never use tabs
> > #1124: FILE: tcmu/helper.c:615:
> > +^I/* This helper fn doesn't support sw write protect (SWP) */$
> > 
> > ERROR: code indent should never use tabs
> > #1126: FILE: tcmu/helper.c:617:
> > +^I/* Don't report block descriptors */$
> > 
> > ERROR: code indent should never use tabs
> > #1128: FILE: tcmu/helper.c:619:
> > +^Iif (page_code == 0x3f) {$
> > 
> > ERROR: code indent should never use tabs
> > #1129: FILE: tcmu/helper.c:620:
> > +^I^Ifor (i = 0; i < ARRAY_SIZE(modesense_handlers); i++) {$
> > 
> > ERROR: code indent should never use tabs
> > #1130: FILE: tcmu/helper.c:621:
> > +^I^I^Iret = handle_mode_sense(dev, &modesense_handlers[i],$
> > 
> > ERROR: code indent should never use tabs
> > #1131: FILE: tcmu/helper.c:622:
> > +^I^I^I^I^I^I&buf, alloc_len, &used_len,$
> > 
> > ERROR: code indent should never use tabs
> > #1132: FILE: tcmu/helper.c:623:
> > +^I^I^I^I^I^Isense_ten);$
> > 
> > ERROR: code indent should never use tabs
> > #1133: FILE: tcmu/helper.c:624:
> > +^I^I^Iif (ret < 0)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1133: FILE: tcmu/helper.c:624:
> > +                       if (ret < 0)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1134: FILE: tcmu/helper.c:625:
> > +^I^I^I^Igoto free_buf;$
> > 
> > ERROR: code indent should never use tabs
> > #1135: FILE: tcmu/helper.c:626:
> > +^I^I}$
> > 
> > ERROR: code indent should never use tabs
> > #1136: FILE: tcmu/helper.c:627:
> > +^I} else {$
> > 
> > ERROR: code indent should never use tabs
> > #1137: FILE: tcmu/helper.c:628:
> > +^I^Iret = 0;$
> > 
> > ERROR: code indent should never use tabs
> > #1139: FILE: tcmu/helper.c:630:
> > +^I^Ifor (i = 0; i < ARRAY_SIZE(modesense_handlers); i++) {$
> > 
> > ERROR: code indent should never use tabs
> > #1140: FILE: tcmu/helper.c:631:
> > +^I^I^Iif (page_code == modesense_handlers[i].page &&$
> > 
> > ERROR: code indent should never use tabs
> > #1141: FILE: tcmu/helper.c:632:
> > +^I^I^I    subpage_code == modesense_handlers[i].subpage) {$
> > 
> > ERROR: code indent should never use tabs
> > #1142: FILE: tcmu/helper.c:633:
> > +^I^I^I^Iret = handle_mode_sense(dev,$
> > 
> > ERROR: code indent should never use tabs
> > #1143: FILE: tcmu/helper.c:634:
> > +^I^I^I^I^I^I^I&modesense_handlers[i],$
> > 
> > ERROR: code indent should never use tabs
> > #1144: FILE: tcmu/helper.c:635:
> > +^I^I^I^I^I^I^I&buf, alloc_len,$
> > 
> > ERROR: code indent should never use tabs
> > #1145: FILE: tcmu/helper.c:636:
> > +^I^I^I^I^I^I^I&used_len, sense_ten);$
> > 
> > ERROR: code indent should never use tabs
> > #1146: FILE: tcmu/helper.c:637:
> > +^I^I^I^Ibreak;$
> > 
> > ERROR: code indent should never use tabs
> > #1147: FILE: tcmu/helper.c:638:
> > +^I^I^I}$
> > 
> > ERROR: code indent should never use tabs
> > #1148: FILE: tcmu/helper.c:639:
> > +^I^I}$
> > 
> > ERROR: code indent should never use tabs
> > #1150: FILE: tcmu/helper.c:641:
> > +^I^Iif (ret <= 0)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1150: FILE: tcmu/helper.c:641:
> > +               if (ret <= 0)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1151: FILE: tcmu/helper.c:642:
> > +^I^I^Igoto free_buf;$
> > 
> > ERROR: code indent should never use tabs
> > #1152: FILE: tcmu/helper.c:643:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #1154: FILE: tcmu/helper.c:645:
> > +^Iif (sense_ten) {$
> > 
> > ERROR: code indent should never use tabs
> > #1155: FILE: tcmu/helper.c:646:
> > +^I^Iuint16_t *ptr = (uint16_t*) orig_buf;$
> > 
> > ERROR: "(foo*)" should be "(foo *)"
> > #1155: FILE: tcmu/helper.c:646:
> > +               uint16_t *ptr = (uint16_t*) orig_buf;
> > 
> > ERROR: code indent should never use tabs
> > #1156: FILE: tcmu/helper.c:647:
> > +^I^I*ptr = htobe16(used_len - 2);$
> > 
> > ERROR: code indent should never use tabs
> > #1157: FILE: tcmu/helper.c:648:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #1158: FILE: tcmu/helper.c:649:
> > +^Ielse {$
> > 
> > ERROR: else should follow close brace '}'
> > #1158: FILE: tcmu/helper.c:649:
> > +       }
> > +       else {
> > 
> > ERROR: code indent should never use tabs
> > #1159: FILE: tcmu/helper.c:650:
> > +^I^Iorig_buf[0] = used_len - 1;$
> > 
> > ERROR: code indent should never use tabs
> > #1160: FILE: tcmu/helper.c:651:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #1162: FILE: tcmu/helper.c:653:
> > +^Itcmu_memcpy_into_iovec(iovec, iov_cnt, orig_buf, alloc_len);$
> > 
> > ERROR: code indent should never use tabs
> > #1163: FILE: tcmu/helper.c:654:
> > +^Ifree(orig_buf);$
> > 
> > ERROR: code indent should never use tabs
> > #1164: FILE: tcmu/helper.c:655:
> > +^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #1167: FILE: tcmu/helper.c:658:
> > +^Ifree(orig_buf);$
> > 
> > ERROR: code indent should never use tabs
> > #1169: FILE: tcmu/helper.c:660:
> > +^Ireturn TCMU_STS_INVALID_CDB;$
> > 
> > ERROR: code indent should never use tabs
> > #1178: FILE: tcmu/helper.c:669:
> > +^Istruct tcmu_device *dev,$
> > 
> > ERROR: code indent should never use tabs
> > #1179: FILE: tcmu/helper.c:670:
> > +^Iuint8_t *cdb,$
> > 
> > ERROR: code indent should never use tabs
> > #1180: FILE: tcmu/helper.c:671:
> > +^Istruct iovec *iovec,$
> > 
> > ERROR: code indent should never use tabs
> > #1181: FILE: tcmu/helper.c:672:
> > +^Isize_t iov_cnt)$
> > 
> > ERROR: code indent should never use tabs
> > #1183: FILE: tcmu/helper.c:674:
> > +^Ibool select_ten = (cdb[0] == MODE_SELECT_10);$
> > 
> > ERROR: code indent should never use tabs
> > #1184: FILE: tcmu/helper.c:675:
> > +^Iuint8_t page_code = cdb[2] & 0x3f;$
> > 
> > ERROR: code indent should never use tabs
> > #1185: FILE: tcmu/helper.c:676:
> > +^Iuint8_t subpage_code = cdb[3];$
> > 
> > ERROR: code indent should never use tabs
> > #1186: FILE: tcmu/helper.c:677:
> > +^Isize_t alloc_len = tcmu_dev_get_max_xfer_len(dev);$
> > 
> > ERROR: code indent should never use tabs
> > #1187: FILE: tcmu/helper.c:678:
> > +^Iint i;$
> > 
> > ERROR: code indent should never use tabs
> > #1188: FILE: tcmu/helper.c:679:
> > +^Iint ret = 0;$
> > 
> > ERROR: code indent should never use tabs
> > #1189: FILE: tcmu/helper.c:680:
> > +^Isize_t hdr_len = select_ten ? 8 : 4;$
> > 
> > ERROR: code indent should never use tabs
> > #1190: FILE: tcmu/helper.c:681:
> > +^Iuint8_t buf[512];$
> > 
> > ERROR: code indent should never use tabs
> > #1191: FILE: tcmu/helper.c:682:
> > +^Iuint8_t in_buf[512];$
> > 
> > ERROR: code indent should never use tabs
> > #1192: FILE: tcmu/helper.c:683:
> > +^Ibool got_sense = false;$
> > 
> > ERROR: code indent should never use tabs
> > #1194: FILE: tcmu/helper.c:685:
> > +^Iif (!alloc_len)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1194: FILE: tcmu/helper.c:685:
> > +       if (!alloc_len)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1195: FILE: tcmu/helper.c:686:
> > +^I^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: line over 90 characters
> > #1197: FILE: tcmu/helper.c:688:
> > +       if (tcmu_memcpy_from_iovec(in_buf, sizeof(in_buf), iovec, iov_cnt) >= sizeof(in_buf))
> > 
> > ERROR: code indent should never use tabs
> > #1197: FILE: tcmu/helper.c:688:
> > +^Iif (tcmu_memcpy_from_iovec(in_buf, sizeof(in_buf), iovec, iov_cnt) >= sizeof(in_buf))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1197: FILE: tcmu/helper.c:688:
> > +       if (tcmu_memcpy_from_iovec(in_buf, sizeof(in_buf), iovec, iov_cnt) >= sizeof(in_buf))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1198: FILE: tcmu/helper.c:689:
> > +^I^Ireturn TCMU_STS_INVALID_PARAM_LIST_LEN;$
> > 
> > ERROR: code indent should never use tabs
> > #1200: FILE: tcmu/helper.c:691:
> > +^I/* Abort if !pf or sp */$
> > 
> > ERROR: code indent should never use tabs
> > #1201: FILE: tcmu/helper.c:692:
> > +^Iif (!(cdb[1] & 0x10) || (cdb[1] & 0x01))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1201: FILE: tcmu/helper.c:692:
> > +       if (!(cdb[1] & 0x10) || (cdb[1] & 0x01))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1202: FILE: tcmu/helper.c:693:
> > +^I^Ireturn TCMU_STS_INVALID_CDB;$
> > 
> > ERROR: code indent should never use tabs
> > #1204: FILE: tcmu/helper.c:695:
> > +^Imemset(buf, 0, sizeof(buf));$
> > 
> > ERROR: code indent should never use tabs
> > #1205: FILE: tcmu/helper.c:696:
> > +^Ifor (i = 0; i < ARRAY_SIZE(modesense_handlers); i++) {$
> > 
> > ERROR: code indent should never use tabs
> > #1206: FILE: tcmu/helper.c:697:
> > +^I^Iif (page_code == modesense_handlers[i].page$
> > 
> > ERROR: code indent should never use tabs
> > #1207: FILE: tcmu/helper.c:698:
> > +^I^I    && subpage_code == modesense_handlers[i].subpage) {$
> > 
> > ERROR: code indent should never use tabs
> > #1208: FILE: tcmu/helper.c:699:
> > +^I^I^Iret = modesense_handlers[i].get(dev, &buf[hdr_len],$
> > 
> > ERROR: code indent should never use tabs
> > #1209: FILE: tcmu/helper.c:700:
> > +^I^I^I^I^I^I^Isizeof(buf) - hdr_len);$
> > 
> > ERROR: code indent should never use tabs
> > #1210: FILE: tcmu/helper.c:701:
> > +^I^I^Iif (ret <= 0)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1210: FILE: tcmu/helper.c:701:
> > +                       if (ret <= 0)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1211: FILE: tcmu/helper.c:702:
> > +^I^I^I^Ireturn TCMU_STS_INVALID_CDB;$
> > 
> > ERROR: code indent should never use tabs
> > #1213: FILE: tcmu/helper.c:704:
> > +^I^I^Iif  (!select_ten && (hdr_len + ret >= 255))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1213: FILE: tcmu/helper.c:704:
> > +                       if  (!select_ten && (hdr_len + ret >= 255))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1214: FILE: tcmu/helper.c:705:
> > +^I^I^I^Ireturn TCMU_STS_INVALID_CDB;$
> > 
> > ERROR: code indent should never use tabs
> > #1216: FILE: tcmu/helper.c:707:
> > +^I^I^Igot_sense = true;$
> > 
> > ERROR: code indent should never use tabs
> > #1217: FILE: tcmu/helper.c:708:
> > +^I^I^Ibreak;$
> > 
> > ERROR: code indent should never use tabs
> > #1218: FILE: tcmu/helper.c:709:
> > +^I^I}$
> > 
> > ERROR: code indent should never use tabs
> > #1219: FILE: tcmu/helper.c:710:
> > +^I}$
> > 
> > ERROR: code indent should never use tabs
> > #1221: FILE: tcmu/helper.c:712:
> > +^Iif (!got_sense)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1221: FILE: tcmu/helper.c:712:
> > +       if (!got_sense)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1222: FILE: tcmu/helper.c:713:
> > +^I^Ireturn TCMU_STS_INVALID_CDB;$
> > 
> > ERROR: code indent should never use tabs
> > #1224: FILE: tcmu/helper.c:715:
> > +^Iif (alloc_len < (hdr_len + ret))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1224: FILE: tcmu/helper.c:715:
> > +       if (alloc_len < (hdr_len + ret))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1225: FILE: tcmu/helper.c:716:
> > +^I^Ireturn TCMU_STS_INVALID_PARAM_LIST_LEN;$
> > 
> > ERROR: code indent should never use tabs
> > #1227: FILE: tcmu/helper.c:718:
> > +^I/* Verify what was selected is identical to what sense returns, since we$
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #1227: FILE: tcmu/helper.c:718:
> > +       /* Verify what was selected is identical to what sense returns, since we
> > 
> > ERROR: code indent should never use tabs
> > #1228: FILE: tcmu/helper.c:719:
> > +^I   don't support actually setting anything. */$
> > 
> > WARNING: Block comments use * on subsequent lines
> > #1228: FILE: tcmu/helper.c:719:
> > +       /* Verify what was selected is identical to what sense returns, since we
> > +          don't support actually setting anything. */
> > 
> > WARNING: Block comments use a trailing */ on a separate line
> > #1228: FILE: tcmu/helper.c:719:
> > +          don't support actually setting anything. */
> > 
> > ERROR: code indent should never use tabs
> > #1229: FILE: tcmu/helper.c:720:
> > +^Iif (memcmp(&buf[hdr_len], &in_buf[hdr_len], ret))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1229: FILE: tcmu/helper.c:720:
> > +       if (memcmp(&buf[hdr_len], &in_buf[hdr_len], ret))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1230: FILE: tcmu/helper.c:721:
> > +^I^Ireturn TCMU_STS_INVALID_PARAM_LIST;$
> > 
> > ERROR: code indent should never use tabs
> > #1232: FILE: tcmu/helper.c:723:
> > +^Ireturn TCMU_STS_OK;$
> > 
> > ERROR: code indent should never use tabs
> > #1237: FILE: tcmu/helper.c:728:
> > +^Iif ((cdb[4] >> 4) & 0xf)$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1237: FILE: tcmu/helper.c:728:
> > +       if ((cdb[4] >> 4) & 0xf)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1238: FILE: tcmu/helper.c:729:
> > +^I^Ireturn TCMU_STS_INVALID_CDB;$
> > 
> > ERROR: code indent should never use tabs
> > #1240: FILE: tcmu/helper.c:731:
> > +^I/* Currently, we don't allow ejecting the medium, so we're$
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #1240: FILE: tcmu/helper.c:731:
> > +       /* Currently, we don't allow ejecting the medium, so we're
> > 
> > ERROR: code indent should never use tabs
> > #1241: FILE: tcmu/helper.c:732:
> > +^I * ignoring the FBO_PREV_EJECT flag, but it may turn out that$
> > 
> > ERROR: code indent should never use tabs
> > #1242: FILE: tcmu/helper.c:733:
> > +^I * initiators do not handle this well, so we may have to change$
> > 
> > ERROR: code indent should never use tabs
> > #1243: FILE: tcmu/helper.c:734:
> > +^I * this behavior.$
> > 
> > ERROR: code indent should never use tabs
> > #1244: FILE: tcmu/helper.c:735:
> > +^I */$
> > 
> > ERROR: code indent should never use tabs
> > #1246: FILE: tcmu/helper.c:737:
> > +^Iif (!(cdb[4] & 0x01))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1246: FILE: tcmu/helper.c:737:
> > +       if (!(cdb[4] & 0x01))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1247: FILE: tcmu/helper.c:738:
> > +^I^Ireturn TCMU_STS_INVALID_CDB;$
> > 
> > ERROR: code indent should never use tabs
> > #1249: FILE: tcmu/helper.c:740:
> > +^Ireturn TCMU_STS_OK;$
> > 
> > WARNING: architecture specific defines should be avoided
> > #1269: FILE: tcmu/helper.h:13:
> > +#ifndef __TCMU_HELPER_H
> > 
> > ERROR: line over 90 characters
> > #1275: FILE: tcmu/helper.h:19:
> > +int tcmu_emulate_inquiry(struct tcmu_device *dev, uint8_t *cdb, struct iovec *iovec, size_t iov_cnt);
> > 
> > WARNING: line over 80 characters
> > #1277: FILE: tcmu/helper.h:21:
> > +int tcmu_emulate_test_unit_ready(uint8_t *cdb, struct iovec *iovec, size_t iov_cnt);
> > 
> > WARNING: line over 80 characters
> > #1278: FILE: tcmu/helper.h:22:
> > +int tcmu_emulate_read_capacity_10(uint64_t num_lbas, uint32_t block_size, uint8_t *cdb,
> > 
> > ERROR: code indent should never use tabs
> > #1279: FILE: tcmu/helper.h:23:
> > +^I^I^I^I  struct iovec *iovec, size_t iov_cnt);$
> > 
> > WARNING: line over 80 characters
> > #1280: FILE: tcmu/helper.h:24:
> > +int tcmu_emulate_read_capacity_16(uint64_t num_lbas, uint32_t block_size, uint8_t *cdb,
> > 
> > ERROR: code indent should never use tabs
> > #1281: FILE: tcmu/helper.h:25:
> > +^I^I^I^I  struct iovec *iovec, size_t iov_cnt);$
> > 
> > ERROR: code indent should never use tabs
> > #1283: FILE: tcmu/helper.h:27:
> > +^I^I^I    struct iovec *iovec, size_t iov_cnt);$
> > 
> > ERROR: code indent should never use tabs
> > #1285: FILE: tcmu/helper.h:29:
> > +^I^I^I     struct iovec *iovec, size_t iov_cnt);$
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #1514: FILE: tcmu/tcmu.c:221:
> > +        { /* end of list */ }
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #1523: FILE: tcmu/tcmu.c:230:
> > +        { /* end of list */ }
> > 
> > ERROR: do not use assignment in if condition
> > #1590: FILE: tcmu/tcmu.c:297:
> > +    if ((aio = qemu_opt_get(common_opts, "aio")) != NULL) {
> > 
> > ERROR: do not use assignment in if condition
> > #1602: FILE: tcmu/tcmu.c:309:
> > +    if ((buf = qemu_opt_get(common_opts, "format")) != NULL) {
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1617: FILE: tcmu/tcmu.c:324:
> > +    if (read_only)
> > [...]
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #1620: FILE: tcmu/tcmu.c:327:
> > +    /* bdrv_open() defaults to the values in bdrv_flags (for compatibility
> > 
> > WARNING: Block comments use a trailing */ on a separate line
> > #1622: FILE: tcmu/tcmu.c:329:
> > +     * Apply the defaults here instead. */
> > 
> > ERROR: space required before the open parenthesis '('
> > #1712: FILE: tcmu/tcmu.c:419:
> > +    if(exp)
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1712: FILE: tcmu/tcmu.c:419:
> > +    if(exp)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1761: FILE: tcmu/tcmu.c:468:
> > +^Iid = device;$
> > 
> > ERROR: code indent should never use tabs
> > #1762: FILE: tcmu/tcmu.c:469:
> > +    ^Iblk = blk_by_name(id);$
> > 
> > ERROR: code indent should never use tabs
> > #1763: FILE: tcmu/tcmu.c:470:
> > +    ^Iif (!blk) {$
> > 
> > ERROR: code indent should never use tabs
> > #1764: FILE: tcmu/tcmu.c:471:
> > +        ^Ierror_setg(errp, "TCMU: Device not found: %s", id);$
> > 
> > ERROR: code indent should never use tabs
> > #1765: FILE: tcmu/tcmu.c:472:
> > +        ^Ireturn false;$
> > 
> > ERROR: code indent should never use tabs
> > #1766: FILE: tcmu/tcmu.c:473:
> > +    ^I}$
> > 
> > ERROR: code indent should never use tabs
> > #1767: FILE: tcmu/tcmu.c:474:
> > +    ^Iexp = tcmu_export_lookup(blk);$
> > 
> > ERROR: code indent should never use tabs
> > #1768: FILE: tcmu/tcmu.c:475:
> > +    ^Iif (!exp) {$
> > 
> > ERROR: code indent should never use tabs
> > #1769: FILE: tcmu/tcmu.c:476:
> > +        ^Ierror_setg(errp, "TCMU: Device not found: %s", id);$
> > 
> > ERROR: code indent should never use tabs
> > #1770: FILE: tcmu/tcmu.c:477:
> > +        ^Ireturn false;$
> > 
> > ERROR: code indent should never use tabs
> > #1771: FILE: tcmu/tcmu.c:478:
> > +   ^I}$
> > 
> > ERROR: do not use C99 // comments
> > #1772: FILE: tcmu/tcmu.c:479:
> > +    }// TODO: else to check id?
> > 
> > ERROR: code indent should never use tabs
> > #1780: FILE: tcmu/tcmu.c:487:
> > +^Iif (*opts == '@') {$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1780: FILE: tcmu/tcmu.c:487:
> > +       if (*opts == '@') {
> > [...]
> > +       } else
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1781: FILE: tcmu/tcmu.c:488:
> > +^I    *to = ',';$
> > 
> > ERROR: code indent should never use tabs
> > #1782: FILE: tcmu/tcmu.c:489:
> > +^I} else$
> > 
> > ERROR: code indent should never use tabs
> > #1783: FILE: tcmu/tcmu.c:490:
> > +^I    *to = *opts;$
> > 
> > ERROR: code indent should never use tabs
> > #1785: FILE: tcmu/tcmu.c:492:
> > +^Iopts++;$
> > 
> > ERROR: code indent should never use tabs
> > #1786: FILE: tcmu/tcmu.c:493:
> > +^Ito++;$
> > 
> > ERROR: space required before the open parenthesis '('
> > #1789: FILE: tcmu/tcmu.c:496:
> > +    if(to)
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1789: FILE: tcmu/tcmu.c:496:
> > +    if(to)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1806: FILE: tcmu/tcmu.c:513:
> > +    ^Iid = device;$
> > 
> > ERROR: code indent should never use tabs
> > #1807: FILE: tcmu/tcmu.c:514:
> > +    ^Iexp = tcmu_export_lookup(blk_by_name(id));$
> > 
> > ERROR: else should follow close brace '}'
> > #1809: FILE: tcmu/tcmu.c:516:
> > +    }
> > +    else {
> > 
> > ERROR: code indent should never use tabs
> > #1810: FILE: tcmu/tcmu.c:517:
> > +^IQemuOpts * export_opts;$
> > 
> > ERROR: "foo * bar" should be "foo *bar"
> > #1810: FILE: tcmu/tcmu.c:517:
> > +       QemuOpts * export_opts;
> > 
> > ERROR: code indent should never use tabs
> > #1812: FILE: tcmu/tcmu.c:519:
> > +^Inew_device = g_malloc0(strlen(device) + 1);$
> > 
> > ERROR: code indent should never use tabs
> > #1813: FILE: tcmu/tcmu.c:520:
> > +^Itcmu_convert_delim(new_device, device);$
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #1815: FILE: tcmu/tcmu.c:522:
> > +        /* parse new_device into an QemuOpts and link into
> > 
> > WARNING: Block comments use * on subsequent lines
> > #1816: FILE: tcmu/tcmu.c:523:
> > +        /* parse new_device into an QemuOpts and link into
> > +           qemu_tcmu_export_opts with QemuOpts->id set while
> > 
> > ERROR: code indent should never use tabs
> > #1819: FILE: tcmu/tcmu.c:526:
> > +^Iexport_opts = qemu_opts_parse_noisily(&qemu_tcmu_export_opts,$
> > 
> > ERROR: code indent should never use tabs
> > #1820: FILE: tcmu/tcmu.c:527:
> > +^I^I^I^I^I    new_device, false);$
> > 
> > ERROR: space required before the open parenthesis '('
> > #1824: FILE: tcmu/tcmu.c:531:
> > +        if(!export_opts)
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1824: FILE: tcmu/tcmu.c:531:
> > +        if(!export_opts)
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1827: FILE: tcmu/tcmu.c:534:
> > +^Iif (export_init_func(NULL, export_opts, NULL))$
> > 
> > ERROR: braces {} are necessary for all arms of this statement
> > #1827: FILE: tcmu/tcmu.c:534:
> > +       if (export_init_func(NULL, export_opts, NULL))
> > [...]
> > 
> > ERROR: code indent should never use tabs
> > #1828: FILE: tcmu/tcmu.c:535:
> > +^I    goto fail;$
> > 
> > ERROR: code indent should never use tabs
> > #1830: FILE: tcmu/tcmu.c:537:
> > +^Iid = qemu_opts_id(export_opts);$
> > 
> > ERROR: code indent should never use tabs
> > #1831: FILE: tcmu/tcmu.c:538:
> > +^Iexp = tcmu_export_lookup(blk_by_name(id));$
> > 
> > total: 620 errors, 26 warnings, 1809 lines checked
> > 
> > Your patch has style problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
> > 
> > === OUTPUT END ===
> > 
> > Test command exited with code: 1
> > 
> > 
> > The full log is available at
> > http://patchew.org/logs/1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com/testing.checkpatch/?type=message.
> > ---
> > Email generated automatically by Patchew [http://patchew.org/].
> > Please send your feedback to patchew-devel@redhat.com
