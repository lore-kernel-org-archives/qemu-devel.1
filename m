Received: from eggs.gnu.org ([2001:4830:134:3::10]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlE-000536-2R
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl5-0007pB-If
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:21 +0200
Message-Id: <1499447335-6125-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 006/100] vvfat: replace tabs by 8 spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

This was a complete mess. On 2299 indented lines:
- 1329 were with spaces only
- 617 with tabulations only
- 353 with spaces and tabulations

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 2054 ++++++++++++++++++++++++++++-----------------------=
------
 1 file changed, 1027 insertions(+), 1027 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 040fb71..e83b8ba 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -100,12 +100,12 @@ static inline void* array_get(array_t* array,unsign=
ed int index) {
 static inline int array_ensure_allocated(array_t* array, int index)
 {
     if((index + 1) * array->item_size > array->size) {
-	int new_size =3D (index + 32) * array->item_size;
-	array->pointer =3D g_realloc(array->pointer, new_size);
-	if (!array->pointer)
-	    return -1;
-	array->size =3D new_size;
-	array->next =3D index + 1;
+        int new_size =3D (index + 32) * array->item_size;
+        array->pointer =3D g_realloc(array->pointer, new_size);
+        if (!array->pointer)
+            return -1;
+        array->size =3D new_size;
+        array->next =3D index + 1;
     }
=20
     return 0;
@@ -115,7 +115,7 @@ static inline void* array_get_next(array_t* array) {
     unsigned int next =3D array->next;
=20
     if (array_ensure_allocated(array, next) < 0)
-	return NULL;
+        return NULL;
=20
     array->next =3D next + 1;
     return array_get(array, next);
@@ -123,15 +123,15 @@ static inline void* array_get_next(array_t* array) =
{
=20
 static inline void* array_insert(array_t* array,unsigned int index,unsig=
ned int count) {
     if((array->next+count)*array->item_size>array->size) {
-	int increment=3Dcount*array->item_size;
-	array->pointer=3Dg_realloc(array->pointer,array->size+increment);
-	if(!array->pointer)
+        int increment=3Dcount*array->item_size;
+        array->pointer=3Dg_realloc(array->pointer,array->size+increment)=
;
+        if(!array->pointer)
             return NULL;
-	array->size+=3Dincrement;
+        array->size+=3Dincrement;
     }
     memmove(array->pointer+(index+count)*array->item_size,
-		array->pointer+index*array->item_size,
-		(array->next-index)*array->item_size);
+                array->pointer+index*array->item_size,
+                (array->next-index)*array->item_size);
     array->next+=3Dcount;
     return array->pointer+index*array->item_size;
 }
@@ -146,12 +146,12 @@ static inline int array_roll(array_t* array,int ind=
ex_to,int index_from,int coun
     int is;
=20
     if(!array ||
-	    index_to<0 || index_to>=3Darray->next ||
-	    index_from<0 || index_from>=3Darray->next)
-	return -1;
+            index_to<0 || index_to>=3Darray->next ||
+            index_from<0 || index_from>=3Darray->next)
+        return -1;
=20
     if(index_to=3D=3Dindex_from)
-	return 0;
+        return 0;
=20
     is=3Darray->item_size;
     from=3Darray->pointer+index_from*is;
@@ -160,9 +160,9 @@ static inline int array_roll(array_t* array,int index=
_to,int index_from,int coun
     memcpy(buf,from,is*count);
=20
     if(index_to<index_from)
-	memmove(to+is*count,to,from-to);
+        memmove(to+is*count,to,from-to);
     else
-	memmove(from,from+is*count,to-from);
+        memmove(from,from+is*count,to-from);
=20
     memcpy(to,buf,is*count);
=20
@@ -177,7 +177,7 @@ static inline int array_remove_slice(array_t* array,i=
nt index, int count)
     assert(count > 0);
     assert(index + count <=3D array->next);
     if(array_roll(array,array->next-1,index,count))
-	return -1;
+        return -1;
     array->next -=3D count;
     return 0;
 }
@@ -216,21 +216,21 @@ typedef struct bootsector_t {
     uint32_t total_sectors;
     union {
         struct {
-	    uint8_t drive_number;
-	    uint8_t current_head;
-	    uint8_t signature;
-	    uint32_t id;
-	    uint8_t volume_label[11];
-	} QEMU_PACKED fat16;
-	struct {
-	    uint32_t sectors_per_fat;
-	    uint16_t flags;
-	    uint8_t major,minor;
-	    uint32_t first_cluster_of_root_directory;
-	    uint16_t info_sector;
-	    uint16_t backup_boot_sector;
-	    uint16_t ignored;
-	} QEMU_PACKED fat32;
+            uint8_t drive_number;
+            uint8_t current_head;
+            uint8_t signature;
+            uint32_t id;
+            uint8_t volume_label[11];
+        } QEMU_PACKED fat16;
+        struct {
+            uint32_t sectors_per_fat;
+            uint16_t flags;
+            uint8_t major,minor;
+            uint32_t first_cluster_of_root_directory;
+            uint16_t info_sector;
+            uint16_t backup_boot_sector;
+            uint16_t ignored;
+        } QEMU_PACKED fat32;
     } u;
     uint8_t fat_type[8];
     uint8_t ignored[0x1c0];
@@ -284,25 +284,25 @@ typedef struct mapping_t {
     /* the clusters of a file may be in any order; this points to the fi=
rst */
     int first_mapping_index;
     union {
-	/* offset is
-	 * - the offset in the file (in clusters) for a file, or
-	 * - the next cluster of the directory for a directory, and
-	 * - the address of the buffer for a faked entry
-	 */
-	struct {
-	    uint32_t offset;
-	} file;
-	struct {
-	    int parent_mapping_index;
-	    int first_dir_index;
-	} dir;
+        /* offset is
+         * - the offset in the file (in clusters) for a file, or
+         * - the next cluster of the directory for a directory, and
+         * - the address of the buffer for a faked entry
+         */
+        struct {
+            uint32_t offset;
+        } file;
+        struct {
+            int parent_mapping_index;
+            int first_dir_index;
+        } dir;
     } info;
     /* path contains the full path, i.e. it always starts with s->path *=
/
     char* path;
=20
     enum { MODE_UNDEFINED =3D 0, MODE_NORMAL =3D 1, MODE_MODIFIED =3D 2,
-	MODE_DIRECTORY =3D 4, MODE_FAKED =3D 8,
-	MODE_DELETED =3D 16, MODE_RENAMED =3D 32 } mode;
+        MODE_DIRECTORY =3D 4, MODE_FAKED =3D 8,
+        MODE_DELETED =3D 16, MODE_RENAMED =3D 32 } mode;
     int read_only;
 } mapping_t;
=20
@@ -419,12 +419,12 @@ static inline int short2long_name(char* dest,const =
char* src)
     int len;
     for(i=3D0;i<129 && src[i];i++) {
         dest[2*i]=3Dsrc[i];
-	dest[2*i+1]=3D0;
+        dest[2*i+1]=3D0;
     }
     len=3D2*i;
     dest[2*i]=3Ddest[2*i+1]=3D0;
     for(i=3D2*i+2;(i%26);i++)
-	dest[i]=3D0xff;
+        dest[i]=3D0xff;
     return len;
 }
=20
@@ -436,19 +436,19 @@ static inline direntry_t* create_long_filename(BDRV=
VVFATState* s,const char* fil
     direntry_t* entry;
=20
     for(i=3D0;i<number_of_entries;i++) {
-	entry=3Darray_get_next(&(s->directory));
-	entry->attributes=3D0xf;
-	entry->reserved[0]=3D0;
-	entry->begin=3D0;
-	entry->name[0]=3D(number_of_entries-i)|(i=3D=3D0?0x40:0);
+        entry=3Darray_get_next(&(s->directory));
+        entry->attributes=3D0xf;
+        entry->reserved[0]=3D0;
+        entry->begin=3D0;
+        entry->name[0]=3D(number_of_entries-i)|(i=3D=3D0?0x40:0);
     }
     for(i=3D0;i<26*number_of_entries;i++) {
-	int offset=3D(i%26);
-	if(offset<10) offset=3D1+offset;
-	else if(offset<22) offset=3D14+offset-10;
-	else offset=3D28+offset-22;
-	entry=3Darray_get(&(s->directory),s->directory.next-1-(i/26));
-	entry->name[offset]=3Dbuffer[i];
+        int offset=3D(i%26);
+        if(offset<10) offset=3D1+offset;
+        else if(offset<22) offset=3D14+offset-10;
+        else offset=3D28+offset-22;
+        entry=3Darray_get(&(s->directory),s->directory.next-1-(i/26));
+        entry->name[offset]=3Dbuffer[i];
     }
     return array_get(&(s->directory),s->directory.next-number_of_entries=
);
 }
@@ -471,7 +471,7 @@ static char is_long_name(const direntry_t* direntry)
 static char is_short_name(const direntry_t* direntry)
 {
     return !is_volume_label(direntry) && !is_long_name(direntry)
-	&& !is_free(direntry);
+        && !is_free(direntry);
 }
=20
 static char is_directory(const direntry_t* direntry)
@@ -527,73 +527,73 @@ static uint16_t fat_datetime(time_t time,int return=
_time) {
     t =3D &t1;
     localtime_r(&time,t);
     if(return_time)
-	return cpu_to_le16((t->tm_sec/2)|(t->tm_min<<5)|(t->tm_hour<<11));
+        return cpu_to_le16((t->tm_sec/2)|(t->tm_min<<5)|(t->tm_hour<<11)=
);
     return cpu_to_le16((t->tm_mday)|((t->tm_mon+1)<<5)|((t->tm_year-80)<=
<9));
 }
=20
 static inline void fat_set(BDRVVVFATState* s,unsigned int cluster,uint32=
_t value)
 {
     if(s->fat_type=3D=3D32) {
-	uint32_t* entry=3Darray_get(&(s->fat),cluster);
-	*entry=3Dcpu_to_le32(value);
+        uint32_t* entry=3Darray_get(&(s->fat),cluster);
+        *entry=3Dcpu_to_le32(value);
     } else if(s->fat_type=3D=3D16) {
-	uint16_t* entry=3Darray_get(&(s->fat),cluster);
-	*entry=3Dcpu_to_le16(value&0xffff);
+        uint16_t* entry=3Darray_get(&(s->fat),cluster);
+        *entry=3Dcpu_to_le16(value&0xffff);
     } else {
-	int offset =3D (cluster*3/2);
-	unsigned char* p =3D array_get(&(s->fat), offset);
+        int offset =3D (cluster*3/2);
+        unsigned char* p =3D array_get(&(s->fat), offset);
         switch (cluster&1) {
-	case 0:
-		p[0] =3D value&0xff;
-		p[1] =3D (p[1]&0xf0) | ((value>>8)&0xf);
-		break;
-	case 1:
-		p[0] =3D (p[0]&0xf) | ((value&0xf)<<4);
-		p[1] =3D (value>>4);
-		break;
-	}
+        case 0:
+                p[0] =3D value&0xff;
+                p[1] =3D (p[1]&0xf0) | ((value>>8)&0xf);
+                break;
+        case 1:
+                p[0] =3D (p[0]&0xf) | ((value&0xf)<<4);
+                p[1] =3D (value>>4);
+                break;
+        }
     }
 }
=20
 static inline uint32_t fat_get(BDRVVVFATState* s,unsigned int cluster)
 {
     if(s->fat_type=3D=3D32) {
-	uint32_t* entry=3Darray_get(&(s->fat),cluster);
-	return le32_to_cpu(*entry);
+        uint32_t* entry=3Darray_get(&(s->fat),cluster);
+        return le32_to_cpu(*entry);
     } else if(s->fat_type=3D=3D16) {
-	uint16_t* entry=3Darray_get(&(s->fat),cluster);
-	return le16_to_cpu(*entry);
+        uint16_t* entry=3Darray_get(&(s->fat),cluster);
+        return le16_to_cpu(*entry);
     } else {
-	const uint8_t* x=3D(uint8_t*)(s->fat.pointer)+cluster*3/2;
-	return ((x[0]|(x[1]<<8))>>(cluster&1?4:0))&0x0fff;
+        const uint8_t* x=3D(uint8_t*)(s->fat.pointer)+cluster*3/2;
+        return ((x[0]|(x[1]<<8))>>(cluster&1?4:0))&0x0fff;
     }
 }
=20
 static inline int fat_eof(BDRVVVFATState* s,uint32_t fat_entry)
 {
     if(fat_entry>s->max_fat_value-8)
-	return -1;
+        return -1;
     return 0;
 }
=20
 static inline void init_fat(BDRVVVFATState* s)
 {
     if (s->fat_type =3D=3D 12) {
-	array_init(&(s->fat),1);
-	array_ensure_allocated(&(s->fat),
-		s->sectors_per_fat * 0x200 * 3 / 2 - 1);
+        array_init(&(s->fat),1);
+        array_ensure_allocated(&(s->fat),
+                s->sectors_per_fat * 0x200 * 3 / 2 - 1);
     } else {
-	array_init(&(s->fat),(s->fat_type=3D=3D32?4:2));
-	array_ensure_allocated(&(s->fat),
-		s->sectors_per_fat * 0x200 / s->fat.item_size - 1);
+        array_init(&(s->fat),(s->fat_type=3D=3D32?4:2));
+        array_ensure_allocated(&(s->fat),
+                s->sectors_per_fat * 0x200 / s->fat.item_size - 1);
     }
     memset(s->fat.pointer,0,s->fat.size);
=20
     switch(s->fat_type) {
-	case 12: s->max_fat_value=3D0xfff; break;
-	case 16: s->max_fat_value=3D0xffff; break;
-	case 32: s->max_fat_value=3D0x0fffffff; break;
-	default: s->max_fat_value=3D0; /* error... */
+        case 12: s->max_fat_value=3D0xfff; break;
+        case 16: s->max_fat_value=3D0xffff; break;
+        case 32: s->max_fat_value=3D0x0fffffff; break;
+        default: s->max_fat_value=3D0; /* error... */
     }
=20
 }
@@ -601,17 +601,17 @@ static inline void init_fat(BDRVVVFATState* s)
 /* TODO: in create_short_filename, 0xe5->0x05 is not yet handled! */
 /* TODO: in parse_short_filename, 0x05->0xe5 is not yet handled! */
 static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
-	unsigned int directory_start, const char* filename, int is_dot)
+        unsigned int directory_start, const char* filename, int is_dot)
 {
     int i,j,long_index=3Ds->directory.next;
     direntry_t* entry =3D NULL;
     direntry_t* entry_long =3D NULL;
=20
     if(is_dot) {
-	entry=3Darray_get_next(&(s->directory));
+        entry=3Darray_get_next(&(s->directory));
         memset(entry->name, 0x20, sizeof(entry->name));
-	memcpy(entry->name,filename,strlen(filename));
-	return entry;
+        memcpy(entry->name,filename,strlen(filename));
+        return entry;
     }
=20
     entry_long=3Dcreate_long_filename(s,filename);
@@ -619,9 +619,9 @@ static inline direntry_t* create_short_and_long_name(=
BDRVVVFATState* s,
     i =3D strlen(filename);
     for(j =3D i - 1; j>0  && filename[j]!=3D'.';j--);
     if (j > 0)
-	i =3D (j > 8 ? 8 : j);
+        i =3D (j > 8 ? 8 : j);
     else if (i > 8)
-	i =3D 8;
+        i =3D 8;
=20
     entry=3Darray_get_next(&(s->directory));
     memset(entry->name, 0x20, sizeof(entry->name));
@@ -635,53 +635,53 @@ static inline direntry_t* create_short_and_long_nam=
e(BDRVVVFATState* s,
=20
     /* upcase & remove unwanted characters */
     for(i=3D10;i>=3D0;i--) {
-	if(i=3D=3D10 || i=3D=3D7) for(;i>0 && entry->name[i]=3D=3D' ';i--);
-	if(entry->name[i]<=3D' ' || entry->name[i]>0x7f
-		|| strchr(".*?<>|\":/\\[];,+=3D'",entry->name[i]))
-	    entry->name[i]=3D'_';
+        if(i=3D=3D10 || i=3D=3D7) for(;i>0 && entry->name[i]=3D=3D' ';i-=
-);
+        if(entry->name[i]<=3D' ' || entry->name[i]>0x7f
+                || strchr(".*?<>|\":/\\[];,+=3D'",entry->name[i]))
+            entry->name[i]=3D'_';
         else if(entry->name[i]>=3D'a' && entry->name[i]<=3D'z')
             entry->name[i]+=3D'A'-'a';
     }
=20
     /* mangle duplicates */
     while(1) {
-	direntry_t* entry1=3Darray_get(&(s->directory),directory_start);
-	int j;
-
-	for(;entry1<entry;entry1++)
-	    if(!is_long_name(entry1) && !memcmp(entry1->name,entry->name,11))
-		break; /* found dupe */
-	if(entry1=3D=3Dentry) /* no dupe found */
-	    break;
-
-	/* use all 8 characters of name */
-	if(entry->name[7]=3D=3D' ') {
-	    int j;
-	    for(j=3D6;j>0 && entry->name[j]=3D=3D' ';j--)
-		entry->name[j]=3D'~';
-	}
-
-	/* increment number */
-	for(j=3D7;j>0 && entry->name[j]=3D=3D'9';j--)
-	    entry->name[j]=3D'0';
-	if(j>0) {
-	    if(entry->name[j]<'0' || entry->name[j]>'9')
-	        entry->name[j]=3D'0';
-	    else
-	        entry->name[j]++;
-	}
+        direntry_t* entry1=3Darray_get(&(s->directory),directory_start);
+        int j;
+
+        for(;entry1<entry;entry1++)
+            if(!is_long_name(entry1) && !memcmp(entry1->name,entry->name=
,11))
+                break; /* found dupe */
+        if(entry1=3D=3Dentry) /* no dupe found */
+            break;
+
+        /* use all 8 characters of name */
+        if(entry->name[7]=3D=3D' ') {
+            int j;
+            for(j=3D6;j>0 && entry->name[j]=3D=3D' ';j--)
+                entry->name[j]=3D'~';
+        }
+
+        /* increment number */
+        for(j=3D7;j>0 && entry->name[j]=3D=3D'9';j--)
+            entry->name[j]=3D'0';
+        if(j>0) {
+            if(entry->name[j]<'0' || entry->name[j]>'9')
+                entry->name[j]=3D'0';
+            else
+                entry->name[j]++;
+        }
     }
=20
     /* calculate checksum; propagate to long name */
     if(entry_long) {
         uint8_t chksum=3Dfat_chksum(entry);
=20
-	/* calculate anew, because realloc could have taken place */
-	entry_long=3Darray_get(&(s->directory),long_index);
-	while(entry_long<entry && is_long_name(entry_long)) {
-	    entry_long->reserved[1]=3Dchksum;
-	    entry_long++;
-	}
+        /* calculate anew, because realloc could have taken place */
+        entry_long=3Darray_get(&(s->directory),long_index);
+        while(entry_long<entry && is_long_name(entry_long)) {
+            entry_long->reserved[1]=3Dchksum;
+            entry_long++;
+        }
     }
=20
     return entry;
@@ -708,80 +708,80 @@ static int read_directory(BDRVVVFATState* s, int ma=
pping_index)
     assert(mapping->mode & MODE_DIRECTORY);
=20
     if(!dir) {
-	mapping->end =3D mapping->begin;
-	return -1;
+        mapping->end =3D mapping->begin;
+        return -1;
     }
=20
     i =3D mapping->info.dir.first_dir_index =3D
-	    first_cluster =3D=3D 0 ? 0 : s->directory.next;
+            first_cluster =3D=3D 0 ? 0 : s->directory.next;
=20
     /* actually read the directory, and allocate the mappings */
     while((entry=3Dreaddir(dir))) {
-	unsigned int length=3Dstrlen(dirname)+2+strlen(entry->d_name);
+        unsigned int length=3Dstrlen(dirname)+2+strlen(entry->d_name);
         char* buffer;
-	direntry_t* direntry;
+        direntry_t* direntry;
         struct stat st;
-	int is_dot=3D!strcmp(entry->d_name,".");
-	int is_dotdot=3D!strcmp(entry->d_name,"..");
+        int is_dot=3D!strcmp(entry->d_name,".");
+        int is_dotdot=3D!strcmp(entry->d_name,"..");
=20
-	if(first_cluster =3D=3D 0 && (is_dotdot || is_dot))
-	    continue;
+        if(first_cluster =3D=3D 0 && (is_dotdot || is_dot))
+            continue;
=20
-	buffer =3D g_malloc(length);
-	snprintf(buffer,length,"%s/%s",dirname,entry->d_name);
+        buffer =3D g_malloc(length);
+        snprintf(buffer,length,"%s/%s",dirname,entry->d_name);
=20
-	if(stat(buffer,&st)<0) {
+        if(stat(buffer,&st)<0) {
             g_free(buffer);
             continue;
-	}
-
-	/* create directory entry for this file */
-	direntry=3Dcreate_short_and_long_name(s, i, entry->d_name,
-		is_dot || is_dotdot);
-	direntry->attributes=3D(S_ISDIR(st.st_mode)?0x10:0x20);
-	direntry->reserved[0]=3Ddirentry->reserved[1]=3D0;
-	direntry->ctime=3Dfat_datetime(st.st_ctime,1);
-	direntry->cdate=3Dfat_datetime(st.st_ctime,0);
-	direntry->adate=3Dfat_datetime(st.st_atime,0);
-	direntry->begin_hi=3D0;
-	direntry->mtime=3Dfat_datetime(st.st_mtime,1);
-	direntry->mdate=3Dfat_datetime(st.st_mtime,0);
-	if(is_dotdot)
-	    set_begin_of_direntry(direntry, first_cluster_of_parent);
-	else if(is_dot)
-	    set_begin_of_direntry(direntry, first_cluster);
-	else
-	    direntry->begin=3D0; /* do that later */
+        }
+
+        /* create directory entry for this file */
+        direntry=3Dcreate_short_and_long_name(s, i, entry->d_name,
+                is_dot || is_dotdot);
+        direntry->attributes=3D(S_ISDIR(st.st_mode)?0x10:0x20);
+        direntry->reserved[0]=3Ddirentry->reserved[1]=3D0;
+        direntry->ctime=3Dfat_datetime(st.st_ctime,1);
+        direntry->cdate=3Dfat_datetime(st.st_ctime,0);
+        direntry->adate=3Dfat_datetime(st.st_atime,0);
+        direntry->begin_hi=3D0;
+        direntry->mtime=3Dfat_datetime(st.st_mtime,1);
+        direntry->mdate=3Dfat_datetime(st.st_mtime,0);
+        if(is_dotdot)
+            set_begin_of_direntry(direntry, first_cluster_of_parent);
+        else if(is_dot)
+            set_begin_of_direntry(direntry, first_cluster);
+        else
+            direntry->begin=3D0; /* do that later */
         if (st.st_size > 0x7fffffff) {
-	    fprintf(stderr, "File %s is larger than 2GB\n", buffer);
+            fprintf(stderr, "File %s is larger than 2GB\n", buffer);
             g_free(buffer);
             closedir(dir);
-	    return -2;
+            return -2;
         }
-	direntry->size=3Dcpu_to_le32(S_ISDIR(st.st_mode)?0:st.st_size);
-
-	/* create mapping for this file */
-	if(!is_dot && !is_dotdot && (S_ISDIR(st.st_mode) || st.st_size)) {
-	    s->current_mapping =3D array_get_next(&(s->mapping));
-	    s->current_mapping->begin=3D0;
-	    s->current_mapping->end=3Dst.st_size;
-	    /*
-	     * we get the direntry of the most recent direntry, which
-	     * contains the short name and all the relevant information.
-	     */
-	    s->current_mapping->dir_index=3Ds->directory.next-1;
-	    s->current_mapping->first_mapping_index =3D -1;
-	    if (S_ISDIR(st.st_mode)) {
-		s->current_mapping->mode =3D MODE_DIRECTORY;
-		s->current_mapping->info.dir.parent_mapping_index =3D
-		    mapping_index;
-	    } else {
-		s->current_mapping->mode =3D MODE_UNDEFINED;
-		s->current_mapping->info.file.offset =3D 0;
-	    }
-	    s->current_mapping->path=3Dbuffer;
-	    s->current_mapping->read_only =3D
-		(st.st_mode & (S_IWUSR | S_IWGRP | S_IWOTH)) =3D=3D 0;
+        direntry->size=3Dcpu_to_le32(S_ISDIR(st.st_mode)?0:st.st_size);
+
+        /* create mapping for this file */
+        if(!is_dot && !is_dotdot && (S_ISDIR(st.st_mode) || st.st_size))=
 {
+            s->current_mapping =3D array_get_next(&(s->mapping));
+            s->current_mapping->begin=3D0;
+            s->current_mapping->end=3Dst.st_size;
+            /*
+             * we get the direntry of the most recent direntry, which
+             * contains the short name and all the relevant information.
+             */
+            s->current_mapping->dir_index=3Ds->directory.next-1;
+            s->current_mapping->first_mapping_index =3D -1;
+            if (S_ISDIR(st.st_mode)) {
+                s->current_mapping->mode =3D MODE_DIRECTORY;
+                s->current_mapping->info.dir.parent_mapping_index =3D
+                    mapping_index;
+            } else {
+                s->current_mapping->mode =3D MODE_UNDEFINED;
+                s->current_mapping->info.file.offset =3D 0;
+            }
+            s->current_mapping->path=3Dbuffer;
+            s->current_mapping->read_only =3D
+                (st.st_mode & (S_IWUSR | S_IWGRP | S_IWOTH)) =3D=3D 0;
         } else {
             g_free(buffer);
         }
@@ -790,25 +790,25 @@ static int read_directory(BDRVVVFATState* s, int ma=
pping_index)
=20
     /* fill with zeroes up to the end of the cluster */
     while(s->directory.next%(0x10*s->sectors_per_cluster)) {
-	direntry_t* direntry=3Darray_get_next(&(s->directory));
-	memset(direntry,0,sizeof(direntry_t));
+        direntry_t* direntry=3Darray_get_next(&(s->directory));
+        memset(direntry,0,sizeof(direntry_t));
     }
=20
 /* TODO: if there are more entries, bootsector has to be adjusted! */
 #define ROOT_ENTRIES (0x02 * 0x10 * s->sectors_per_cluster)
     if (mapping_index =3D=3D 0 && s->directory.next < ROOT_ENTRIES) {
-	/* root directory */
-	int cur =3D s->directory.next;
-	array_ensure_allocated(&(s->directory), ROOT_ENTRIES - 1);
-	s->directory.next =3D ROOT_ENTRIES;
-	memset(array_get(&(s->directory), cur), 0,
-		(ROOT_ENTRIES - cur) * sizeof(direntry_t));
+        /* root directory */
+        int cur =3D s->directory.next;
+        array_ensure_allocated(&(s->directory), ROOT_ENTRIES - 1);
+        s->directory.next =3D ROOT_ENTRIES;
+        memset(array_get(&(s->directory), cur), 0,
+                (ROOT_ENTRIES - cur) * sizeof(direntry_t));
     }
=20
      /* reget the mapping, since s->mapping was possibly realloc()ed */
     mapping =3D array_get(&(s->mapping), mapping_index);
     first_cluster +=3D (s->directory.next - mapping->info.dir.first_dir_=
index)
-	* 0x20 / s->cluster_size;
+        * 0x20 / s->cluster_size;
     mapping->end =3D first_cluster;
=20
     direntry =3D array_get(&(s->directory), mapping->dir_index);
@@ -856,8 +856,8 @@ static int init_directories(BDRVVVFATState* s,
=20
     /* add volume label */
     {
-	direntry_t* entry=3Darray_get_next(&(s->directory));
-	entry->attributes=3D0x28; /* archive | volume label */
+        direntry_t* entry=3Darray_get_next(&(s->directory));
+        entry->attributes=3D0x28; /* archive | volume label */
         memcpy(entry->name, s->volume_label, sizeof(entry->name));
     }
=20
@@ -875,61 +875,61 @@ static int init_directories(BDRVVVFATState* s,
     mapping->path =3D g_strdup(dirname);
     i =3D strlen(mapping->path);
     if (i > 0 && mapping->path[i - 1] =3D=3D '/')
-	mapping->path[i - 1] =3D '\0';
+        mapping->path[i - 1] =3D '\0';
     mapping->mode =3D MODE_DIRECTORY;
     mapping->read_only =3D 0;
     s->path =3D mapping->path;
=20
     for (i =3D 0, cluster =3D 0; i < s->mapping.next; i++) {
-	/* MS-DOS expects the FAT to be 0 for the root directory
-	 * (except for the media byte). */
-	/* LATER TODO: still true for FAT32? */
-	int fix_fat =3D (i !=3D 0);
-	mapping =3D array_get(&(s->mapping), i);
+        /* MS-DOS expects the FAT to be 0 for the root directory
+         * (except for the media byte). */
+        /* LATER TODO: still true for FAT32? */
+        int fix_fat =3D (i !=3D 0);
+        mapping =3D array_get(&(s->mapping), i);
=20
         if (mapping->mode & MODE_DIRECTORY) {
-	    mapping->begin =3D cluster;
-	    if(read_directory(s, i)) {
+            mapping->begin =3D cluster;
+            if(read_directory(s, i)) {
                 error_setg(errp, "Could not read directory %s",
                            mapping->path);
-		return -1;
-	    }
-	    mapping =3D array_get(&(s->mapping), i);
-	} else {
-	    assert(mapping->mode =3D=3D MODE_UNDEFINED);
-	    mapping->mode=3DMODE_NORMAL;
-	    mapping->begin =3D cluster;
-	    if (mapping->end > 0) {
-		direntry_t* direntry =3D array_get(&(s->directory),
-			mapping->dir_index);
-
-		mapping->end =3D cluster + 1 + (mapping->end-1)/s->cluster_size;
-		set_begin_of_direntry(direntry, mapping->begin);
-	    } else {
-		mapping->end =3D cluster + 1;
-		fix_fat =3D 0;
-	    }
-	}
-
-	assert(mapping->begin < mapping->end);
-
-	/* next free cluster */
-	cluster =3D mapping->end;
-
-	if(cluster > s->cluster_count) {
+                return -1;
+            }
+            mapping =3D array_get(&(s->mapping), i);
+        } else {
+            assert(mapping->mode =3D=3D MODE_UNDEFINED);
+            mapping->mode=3DMODE_NORMAL;
+            mapping->begin =3D cluster;
+            if (mapping->end > 0) {
+                direntry_t* direntry =3D array_get(&(s->directory),
+                        mapping->dir_index);
+
+                mapping->end =3D cluster + 1 + (mapping->end-1)/s->clust=
er_size;
+                set_begin_of_direntry(direntry, mapping->begin);
+            } else {
+                mapping->end =3D cluster + 1;
+                fix_fat =3D 0;
+            }
+        }
+
+        assert(mapping->begin < mapping->end);
+
+        /* next free cluster */
+        cluster =3D mapping->end;
+
+        if(cluster > s->cluster_count) {
             error_setg(errp,
                        "Directory does not fit in FAT%d (capacity %.2f M=
B)",
                        s->fat_type, s->sector_count / 2000.0);
             return -1;
-	}
+        }
=20
-	/* fix fat for entry */
-	if (fix_fat) {
-	    int j;
-	    for(j =3D mapping->begin; j < mapping->end - 1; j++)
-		fat_set(s, j, j+1);
-	    fat_set(s, mapping->end - 1, s->max_fat_value);
-	}
+        /* fix fat for entry */
+        if (fix_fat) {
+            int j;
+            for(j =3D mapping->begin; j < mapping->end - 1; j++)
+                fat_set(s, j, j+1);
+            fat_set(s, mapping->end - 1, s->max_fat_value);
+        }
     }
=20
     mapping =3D array_get(&(s->mapping), 0);
@@ -1135,7 +1135,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *=
options, int flags,
=20
     switch (s->fat_type) {
     case 32:
-	    fprintf(stderr, "Big fat greek warning: FAT32 has not been tested. =
"
+            fprintf(stderr, "Big fat greek warning: FAT32 has not been t=
ested. "
                 "You are welcome to do so!\n");
         break;
     case 16:
@@ -1229,11 +1229,11 @@ static void vvfat_refresh_limits(BlockDriverState=
 *bs, Error **errp)
 static inline void vvfat_close_current_file(BDRVVVFATState *s)
 {
     if(s->current_mapping) {
-	s->current_mapping =3D NULL;
-	if (s->current_fd) {
-		qemu_close(s->current_fd);
-		s->current_fd =3D 0;
-	}
+        s->current_mapping =3D NULL;
+        if (s->current_fd) {
+                qemu_close(s->current_fd);
+                s->current_fd =3D 0;
+        }
     }
     s->current_cluster =3D -1;
 }
@@ -1245,26 +1245,26 @@ static inline int find_mapping_for_cluster_aux(BD=
RVVVFATState* s,int cluster_num
 {
     while(1) {
         int index3;
-	mapping_t* mapping;
-	index3=3D(index1+index2)/2;
-	mapping=3Darray_get(&(s->mapping),index3);
-	assert(mapping->begin < mapping->end);
-	if(mapping->begin>=3Dcluster_num) {
-	    assert(index2!=3Dindex3 || index2=3D=3D0);
-	    if(index2=3D=3Dindex3)
-		return index1;
-	    index2=3Dindex3;
-	} else {
-	    if(index1=3D=3Dindex3)
-		return mapping->end<=3Dcluster_num ? index2 : index1;
-	    index1=3Dindex3;
-	}
-	assert(index1<=3Dindex2);
-	DLOG(mapping=3Darray_get(&(s->mapping),index1);
-	assert(mapping->begin<=3Dcluster_num);
-	assert(index2 >=3D s->mapping.next ||
-		((mapping =3D array_get(&(s->mapping),index2)) &&
-		mapping->end>cluster_num)));
+        mapping_t* mapping;
+        index3=3D(index1+index2)/2;
+        mapping=3Darray_get(&(s->mapping),index3);
+        assert(mapping->begin < mapping->end);
+        if(mapping->begin>=3Dcluster_num) {
+            assert(index2!=3Dindex3 || index2=3D=3D0);
+            if(index2=3D=3Dindex3)
+                return index1;
+            index2=3Dindex3;
+        } else {
+            if(index1=3D=3Dindex3)
+                return mapping->end<=3Dcluster_num ? index2 : index1;
+            index1=3Dindex3;
+        }
+        assert(index1<=3Dindex2);
+        DLOG(mapping=3Darray_get(&(s->mapping),index1);
+        assert(mapping->begin<=3Dcluster_num);
+        assert(index2 >=3D s->mapping.next ||
+                ((mapping =3D array_get(&(s->mapping),index2)) &&
+                mapping->end>cluster_num)));
     }
 }
=20
@@ -1284,16 +1284,16 @@ static inline mapping_t* find_mapping_for_cluster=
(BDRVVVFATState* s,int cluster_
 static int open_file(BDRVVVFATState* s,mapping_t* mapping)
 {
     if(!mapping)
-	return -1;
+        return -1;
     if(!s->current_mapping ||
-	    strcmp(s->current_mapping->path,mapping->path)) {
-	/* open file */
-	int fd =3D qemu_open(mapping->path, O_RDONLY | O_BINARY | O_LARGEFILE);
-	if(fd<0)
-	    return -1;
-	vvfat_close_current_file(s);
-	s->current_fd =3D fd;
-	s->current_mapping =3D mapping;
+            strcmp(s->current_mapping->path,mapping->path)) {
+        /* open file */
+        int fd =3D qemu_open(mapping->path, O_RDONLY | O_BINARY | O_LARG=
EFILE);
+        if(fd<0)
+            return -1;
+        vvfat_close_current_file(s);
+        s->current_fd =3D fd;
+        s->current_mapping =3D mapping;
     }
     return 0;
 }
@@ -1301,47 +1301,47 @@ static int open_file(BDRVVVFATState* s,mapping_t*=
 mapping)
 static inline int read_cluster(BDRVVVFATState *s,int cluster_num)
 {
     if(s->current_cluster !=3D cluster_num) {
-	int result=3D0;
-	off_t offset;
-	assert(!s->current_mapping || s->current_fd || (s->current_mapping->mod=
e & MODE_DIRECTORY));
-	if(!s->current_mapping
-		|| s->current_mapping->begin>cluster_num
-		|| s->current_mapping->end<=3Dcluster_num) {
-	    /* binary search of mappings for file */
-	    mapping_t* mapping=3Dfind_mapping_for_cluster(s,cluster_num);
-
-	    assert(!mapping || (cluster_num>=3Dmapping->begin && cluster_num<ma=
pping->end));
-
-	    if (mapping && mapping->mode & MODE_DIRECTORY) {
-		vvfat_close_current_file(s);
-		s->current_mapping =3D mapping;
+        int result=3D0;
+        off_t offset;
+        assert(!s->current_mapping || s->current_fd || (s->current_mappi=
ng->mode & MODE_DIRECTORY));
+        if(!s->current_mapping
+                || s->current_mapping->begin>cluster_num
+                || s->current_mapping->end<=3Dcluster_num) {
+            /* binary search of mappings for file */
+            mapping_t* mapping=3Dfind_mapping_for_cluster(s,cluster_num)=
;
+
+            assert(!mapping || (cluster_num>=3Dmapping->begin && cluster=
_num<mapping->end));
+
+            if (mapping && mapping->mode & MODE_DIRECTORY) {
+                vvfat_close_current_file(s);
+                s->current_mapping =3D mapping;
 read_cluster_directory:
-		offset =3D s->cluster_size*(cluster_num-s->current_mapping->begin);
-		s->cluster =3D (unsigned char*)s->directory.pointer+offset
-			+ 0x20*s->current_mapping->info.dir.first_dir_index;
-		assert(((s->cluster-(unsigned char*)s->directory.pointer)%s->cluster_s=
ize)=3D=3D0);
-		assert((char*)s->cluster+s->cluster_size <=3D s->directory.pointer+s->=
directory.next*s->directory.item_size);
-		s->current_cluster =3D cluster_num;
-		return 0;
-	    }
-
-	    if(open_file(s,mapping))
-		return -2;
-	} else if (s->current_mapping->mode & MODE_DIRECTORY)
-	    goto read_cluster_directory;
-
-	assert(s->current_fd);
-
-	offset=3Ds->cluster_size*(cluster_num-s->current_mapping->begin)+s->cur=
rent_mapping->info.file.offset;
-	if(lseek(s->current_fd, offset, SEEK_SET)!=3Doffset)
-	    return -3;
-	s->cluster=3Ds->cluster_buffer;
-	result=3Dread(s->current_fd,s->cluster,s->cluster_size);
-	if(result<0) {
-	    s->current_cluster =3D -1;
-	    return -1;
-	}
-	s->current_cluster =3D cluster_num;
+                offset =3D s->cluster_size*(cluster_num-s->current_mappi=
ng->begin);
+                s->cluster =3D (unsigned char*)s->directory.pointer+offs=
et
+                        + 0x20*s->current_mapping->info.dir.first_dir_in=
dex;
+                assert(((s->cluster-(unsigned char*)s->directory.pointer=
)%s->cluster_size)=3D=3D0);
+                assert((char*)s->cluster+s->cluster_size <=3D s->directo=
ry.pointer+s->directory.next*s->directory.item_size);
+                s->current_cluster =3D cluster_num;
+                return 0;
+            }
+
+            if(open_file(s,mapping))
+                return -2;
+        } else if (s->current_mapping->mode & MODE_DIRECTORY)
+            goto read_cluster_directory;
+
+        assert(s->current_fd);
+
+        offset=3Ds->cluster_size*(cluster_num-s->current_mapping->begin)=
+s->current_mapping->info.file.offset;
+        if(lseek(s->current_fd, offset, SEEK_SET)!=3Doffset)
+            return -3;
+        s->cluster=3Ds->cluster_buffer;
+        result=3Dread(s->current_fd,s->cluster,s->cluster_size);
+        if(result<0) {
+            s->current_cluster =3D -1;
+            return -1;
+        }
+        s->current_cluster =3D cluster_num;
     }
     return 0;
 }
@@ -1354,28 +1354,28 @@ static void print_direntry(const direntry_t* dire=
ntry)
=20
     fprintf(stderr, "direntry %p: ", direntry);
     if(!direntry)
-	return;
+        return;
     if(is_long_name(direntry)) {
-	unsigned char* c=3D(unsigned char*)direntry;
-	int i;
-	for(i=3D1;i<11 && c[i] && c[i]!=3D0xff;i+=3D2)
+        unsigned char* c=3D(unsigned char*)direntry;
+        int i;
+        for(i=3D1;i<11 && c[i] && c[i]!=3D0xff;i+=3D2)
 #define ADD_CHAR(c) {buffer[j] =3D (c); if (buffer[j] < ' ') buffer[j] =3D=
 0xb0; j++;}
-	    ADD_CHAR(c[i]);
-	for(i=3D14;i<26 && c[i] && c[i]!=3D0xff;i+=3D2)
-	    ADD_CHAR(c[i]);
-	for(i=3D28;i<32 && c[i] && c[i]!=3D0xff;i+=3D2)
-	    ADD_CHAR(c[i]);
-	buffer[j] =3D 0;
-	fprintf(stderr, "%s\n", buffer);
+            ADD_CHAR(c[i]);
+        for(i=3D14;i<26 && c[i] && c[i]!=3D0xff;i+=3D2)
+            ADD_CHAR(c[i]);
+        for(i=3D28;i<32 && c[i] && c[i]!=3D0xff;i+=3D2)
+            ADD_CHAR(c[i]);
+        buffer[j] =3D 0;
+        fprintf(stderr, "%s\n", buffer);
     } else {
-	int i;
-	for(i=3D0;i<11;i++)
-	    ADD_CHAR(direntry->name[i]);
-	buffer[j] =3D 0;
-	fprintf(stderr,"%s attributes=3D0x%02x begin=3D%d size=3D%d\n",
-		buffer,
-		direntry->attributes,
-		begin_of_direntry(direntry),le32_to_cpu(direntry->size));
+        int i;
+        for(i=3D0;i<11;i++)
+            ADD_CHAR(direntry->name[i]);
+        buffer[j] =3D 0;
+        fprintf(stderr,"%s attributes=3D0x%02x begin=3D%d size=3D%d\n",
+                buffer,
+                direntry->attributes,
+                begin_of_direntry(direntry),le32_to_cpu(direntry->size))=
;
     }
 }
=20
@@ -1387,9 +1387,9 @@ static void print_mapping(const mapping_t* mapping)
         mapping->first_mapping_index, mapping->path, mapping->mode);
=20
     if (mapping->mode & MODE_DIRECTORY)
-	fprintf(stderr, "parent_mapping_index =3D %d, first_dir_index =3D %d\n"=
, mapping->info.dir.parent_mapping_index, mapping->info.dir.first_dir_ind=
ex);
+        fprintf(stderr, "parent_mapping_index =3D %d, first_dir_index =3D=
 %d\n", mapping->info.dir.parent_mapping_index, mapping->info.dir.first_d=
ir_index);
     else
-	fprintf(stderr, "offset =3D %d\n", mapping->info.file.offset);
+        fprintf(stderr, "offset =3D %d\n", mapping->info.file.offset);
 }
 #endif
=20
@@ -1400,10 +1400,10 @@ static int vvfat_read(BlockDriverState *bs, int64=
_t sector_num,
     int i;
=20
     for(i=3D0;i<nb_sectors;i++,sector_num++) {
-	if (sector_num >=3D bs->total_sectors)
-	   return -1;
-	if (s->qcow) {
-	    int n;
+        if (sector_num >=3D bs->total_sectors)
+           return -1;
+        if (s->qcow) {
+            int n;
             int ret;
             ret =3D bdrv_is_allocated(s->qcow->bs, sector_num,
                                     nb_sectors - i, &n);
@@ -1421,25 +1421,25 @@ static int vvfat_read(BlockDriverState *bs, int64=
_t sector_num,
                 continue;
             }
 DLOG(fprintf(stderr, "sector %d not allocated\n", (int)sector_num));
-	}
-	if(sector_num<s->faked_sectors) {
-	    if(sector_num<s->first_sectors_number)
-		memcpy(buf+i*0x200,&(s->first_sectors[sector_num*0x200]),0x200);
-	    else if(sector_num-s->first_sectors_number<s->sectors_per_fat)
-		memcpy(buf+i*0x200,&(s->fat.pointer[(sector_num-s->first_sectors_numbe=
r)*0x200]),0x200);
-	    else if(sector_num-s->first_sectors_number-s->sectors_per_fat<s->se=
ctors_per_fat)
-		memcpy(buf+i*0x200,&(s->fat.pointer[(sector_num-s->first_sectors_numbe=
r-s->sectors_per_fat)*0x200]),0x200);
-	} else {
-	    uint32_t sector=3Dsector_num-s->faked_sectors,
-	    sector_offset_in_cluster=3D(sector%s->sectors_per_cluster),
-	    cluster_num=3Dsector/s->sectors_per_cluster;
-	    if(cluster_num > s->cluster_count || read_cluster(s, cluster_num) !=
=3D 0) {
-		/* LATER TODO: strict: return -1; */
-		memset(buf+i*0x200,0,0x200);
-		continue;
-	    }
-	    memcpy(buf+i*0x200,s->cluster+sector_offset_in_cluster*0x200,0x200)=
;
-	}
+        }
+        if(sector_num<s->faked_sectors) {
+            if(sector_num<s->first_sectors_number)
+                memcpy(buf+i*0x200,&(s->first_sectors[sector_num*0x200])=
,0x200);
+            else if(sector_num-s->first_sectors_number<s->sectors_per_fa=
t)
+                memcpy(buf+i*0x200,&(s->fat.pointer[(sector_num-s->first=
_sectors_number)*0x200]),0x200);
+            else if(sector_num-s->first_sectors_number-s->sectors_per_fa=
t<s->sectors_per_fat)
+                memcpy(buf+i*0x200,&(s->fat.pointer[(sector_num-s->first=
_sectors_number-s->sectors_per_fat)*0x200]),0x200);
+        } else {
+            uint32_t sector=3Dsector_num-s->faked_sectors,
+            sector_offset_in_cluster=3D(sector%s->sectors_per_cluster),
+            cluster_num=3Dsector/s->sectors_per_cluster;
+            if(cluster_num > s->cluster_count || read_cluster(s, cluster=
_num) !=3D 0) {
+                /* LATER TODO: strict: return -1; */
+                memset(buf+i*0x200,0,0x200);
+                continue;
+            }
+            memcpy(buf+i*0x200,s->cluster+sector_offset_in_cluster*0x200=
,0x200);
+        }
     }
     return 0;
 }
@@ -1497,14 +1497,14 @@ vvfat_co_preadv(BlockDriverState *bs, uint64_t of=
fset, uint64_t bytes,
 typedef struct commit_t {
     char* path;
     union {
-	struct { uint32_t cluster; } rename;
-	struct { int dir_index; uint32_t modified_offset; } writeout;
-	struct { uint32_t first_cluster; } new_file;
-	struct { uint32_t cluster; } mkdir;
+        struct { uint32_t cluster; } rename;
+        struct { int dir_index; uint32_t modified_offset; } writeout;
+        struct { uint32_t first_cluster; } new_file;
+        struct { uint32_t cluster; } mkdir;
     } param;
     /* DELETEs and RMDIRs are handled differently: see handle_deletes() =
*/
     enum {
-	ACTION_RENAME, ACTION_WRITEOUT, ACTION_NEW_FILE, ACTION_MKDIR
+        ACTION_RENAME, ACTION_WRITEOUT, ACTION_NEW_FILE, ACTION_MKDIR
     } action;
 } commit_t;
=20
@@ -1513,19 +1513,19 @@ static void clear_commits(BDRVVVFATState* s)
     int i;
 DLOG(fprintf(stderr, "clear_commits (%d commits)\n", s->commits.next));
     for (i =3D 0; i < s->commits.next; i++) {
-	commit_t* commit =3D array_get(&(s->commits), i);
-	assert(commit->path || commit->action =3D=3D ACTION_WRITEOUT);
-	if (commit->action !=3D ACTION_WRITEOUT) {
-	    assert(commit->path);
+        commit_t* commit =3D array_get(&(s->commits), i);
+        assert(commit->path || commit->action =3D=3D ACTION_WRITEOUT);
+        if (commit->action !=3D ACTION_WRITEOUT) {
+            assert(commit->path);
             g_free(commit->path);
-	} else
-	    assert(commit->path =3D=3D NULL);
+        } else
+            assert(commit->path =3D=3D NULL);
     }
     s->commits.next =3D 0;
 }
=20
 static void schedule_rename(BDRVVVFATState* s,
-	uint32_t cluster, char* new_path)
+        uint32_t cluster, char* new_path)
 {
     commit_t* commit =3D array_get_next(&(s->commits));
     commit->path =3D new_path;
@@ -1534,7 +1534,7 @@ static void schedule_rename(BDRVVVFATState* s,
 }
=20
 static void schedule_writeout(BDRVVVFATState* s,
-	int dir_index, uint32_t modified_offset)
+        int dir_index, uint32_t modified_offset)
 {
     commit_t* commit =3D array_get_next(&(s->commits));
     commit->path =3D NULL;
@@ -1544,7 +1544,7 @@ static void schedule_writeout(BDRVVVFATState* s,
 }
=20
 static void schedule_new_file(BDRVVVFATState* s,
-	char* path, uint32_t first_cluster)
+        char* path, uint32_t first_cluster)
 {
     commit_t* commit =3D array_get_next(&(s->commits));
     commit->path =3D path;
@@ -1579,72 +1579,72 @@ static void lfn_init(long_file_name* lfn)
=20
 /* return 0 if parsed successfully, > 0 if no long name, < 0 if error */
 static int parse_long_name(long_file_name* lfn,
-	const direntry_t* direntry)
+        const direntry_t* direntry)
 {
     int i, j, offset;
     const unsigned char* pointer =3D (const unsigned char*)direntry;
=20
     if (!is_long_name(direntry))
-	return 1;
+        return 1;
=20
     if (pointer[0] & 0x40) {
-	lfn->sequence_number =3D pointer[0] & 0x3f;
-	lfn->checksum =3D pointer[13];
-	lfn->name[0] =3D 0;
-	lfn->name[lfn->sequence_number * 13] =3D 0;
+        lfn->sequence_number =3D pointer[0] & 0x3f;
+        lfn->checksum =3D pointer[13];
+        lfn->name[0] =3D 0;
+        lfn->name[lfn->sequence_number * 13] =3D 0;
     } else if ((pointer[0] & 0x3f) !=3D --lfn->sequence_number)
-	return -1;
+        return -1;
     else if (pointer[13] !=3D lfn->checksum)
-	return -2;
+        return -2;
     else if (pointer[12] || pointer[26] || pointer[27])
-	return -3;
+        return -3;
=20
     offset =3D 13 * (lfn->sequence_number - 1);
     for (i =3D 0, j =3D 1; i < 13; i++, j+=3D2) {
-	if (j =3D=3D 11)
-	    j =3D 14;
-	else if (j =3D=3D 26)
-	    j =3D 28;
+        if (j =3D=3D 11)
+            j =3D 14;
+        else if (j =3D=3D 26)
+            j =3D 28;
=20
-	if (pointer[j+1] =3D=3D 0)
-	    lfn->name[offset + i] =3D pointer[j];
-	else if (pointer[j+1] !=3D 0xff || (pointer[0] & 0x40) =3D=3D 0)
-	    return -4;
-	else
-	    lfn->name[offset + i] =3D 0;
+        if (pointer[j+1] =3D=3D 0)
+            lfn->name[offset + i] =3D pointer[j];
+        else if (pointer[j+1] !=3D 0xff || (pointer[0] & 0x40) =3D=3D 0)
+            return -4;
+        else
+            lfn->name[offset + i] =3D 0;
     }
=20
     if (pointer[0] & 0x40)
-	lfn->len =3D offset + strlen((char*)lfn->name + offset);
+        lfn->len =3D offset + strlen((char*)lfn->name + offset);
=20
     return 0;
 }
=20
 /* returns 0 if successful, >0 if no short_name, and <0 on error */
 static int parse_short_name(BDRVVVFATState* s,
-	long_file_name* lfn, direntry_t* direntry)
+        long_file_name* lfn, direntry_t* direntry)
 {
     int i, j;
=20
     if (!is_short_name(direntry))
-	return 1;
+        return 1;
=20
     for (j =3D 7; j >=3D 0 && direntry->name[j] =3D=3D ' '; j--);
     for (i =3D 0; i <=3D j; i++) {
-	if (direntry->name[i] <=3D ' ' || direntry->name[i] > 0x7f)
-	    return -1;
-	else if (s->downcase_short_names)
-	    lfn->name[i] =3D qemu_tolower(direntry->name[i]);
-	else
-	    lfn->name[i] =3D direntry->name[i];
+        if (direntry->name[i] <=3D ' ' || direntry->name[i] > 0x7f)
+            return -1;
+        else if (s->downcase_short_names)
+            lfn->name[i] =3D qemu_tolower(direntry->name[i]);
+        else
+            lfn->name[i] =3D direntry->name[i];
     }
=20
     for (j =3D 2; j >=3D 0 && direntry->name[8 + j] =3D=3D ' '; j--) {
     }
     if (j >=3D 0) {
-	lfn->name[i++] =3D '.';
-	lfn->name[i + j + 1] =3D '\0';
-	for (;j >=3D 0; j--) {
+        lfn->name[i++] =3D '.';
+        lfn->name[i + j + 1] =3D '\0';
+        for (;j >=3D 0; j--) {
             uint8_t c =3D direntry->name[8 + j];
             if (c <=3D ' ' || c > 0x7f) {
                 return -2;
@@ -1653,9 +1653,9 @@ static int parse_short_name(BDRVVVFATState* s,
             } else {
                 lfn->name[i + j] =3D c;
             }
-	}
+        }
     } else
-	lfn->name[i + j + 1] =3D '\0';
+        lfn->name[i + j + 1] =3D '\0';
=20
     lfn->len =3D strlen((char*)lfn->name);
=20
@@ -1663,13 +1663,13 @@ static int parse_short_name(BDRVVVFATState* s,
 }
=20
 static inline uint32_t modified_fat_get(BDRVVVFATState* s,
-	unsigned int cluster)
+        unsigned int cluster)
 {
     if (cluster < s->last_cluster_of_root_directory) {
-	if (cluster + 1 =3D=3D s->last_cluster_of_root_directory)
-	    return s->max_fat_value;
-	else
-	    return cluster + 1;
+        if (cluster + 1 =3D=3D s->last_cluster_of_root_directory)
+            return s->max_fat_value;
+        else
+            return cluster + 1;
     }
=20
     if (s->fat_type=3D=3D32) {
@@ -1713,9 +1713,9 @@ static const char* get_basename(const char* path)
 {
     char* basename =3D strrchr(path, '/');
     if (basename =3D=3D NULL)
-	return path;
+        return path;
     else
-	return basename + 1; /* strip '/' */
+        return basename + 1; /* strip '/' */
 }
=20
 /*
@@ -1740,7 +1740,7 @@ typedef enum {
  * assumed to be *not* deleted (and *only* those).
  */
 static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
-	direntry_t* direntry, const char* path)
+        direntry_t* direntry, const char* path)
 {
     /*
      * This is a little bit tricky:
@@ -1773,85 +1773,85 @@ static uint32_t get_cluster_count_for_direntry(BD=
RVVVFATState* s,
=20
     /* the root directory */
     if (cluster_num =3D=3D 0)
-	return 0;
+        return 0;
=20
     /* write support */
     if (s->qcow) {
-	basename2 =3D get_basename(path);
+        basename2 =3D get_basename(path);
=20
-	mapping =3D find_mapping_for_cluster(s, cluster_num);
+        mapping =3D find_mapping_for_cluster(s, cluster_num);
=20
-	if (mapping) {
-	    const char* basename;
+        if (mapping) {
+            const char* basename;
=20
-	    assert(mapping->mode & MODE_DELETED);
-	    mapping->mode &=3D ~MODE_DELETED;
+            assert(mapping->mode & MODE_DELETED);
+            mapping->mode &=3D ~MODE_DELETED;
=20
-	    basename =3D get_basename(mapping->path);
+            basename =3D get_basename(mapping->path);
=20
-	    assert(mapping->mode & MODE_NORMAL);
+            assert(mapping->mode & MODE_NORMAL);
=20
-	    /* rename */
-	    if (strcmp(basename, basename2))
-		schedule_rename(s, cluster_num, g_strdup(path));
-	} else if (is_file(direntry))
-	    /* new file */
-	    schedule_new_file(s, g_strdup(path), cluster_num);
-	else {
+            /* rename */
+            if (strcmp(basename, basename2))
+                schedule_rename(s, cluster_num, g_strdup(path));
+        } else if (is_file(direntry))
+            /* new file */
+            schedule_new_file(s, g_strdup(path), cluster_num);
+        else {
             abort();
-	    return 0;
-	}
+            return 0;
+        }
     }
=20
     while(1) {
-	if (s->qcow) {
-	    if (!copy_it && cluster_was_modified(s, cluster_num)) {
-		if (mapping =3D=3D NULL ||
-			mapping->begin > cluster_num ||
-			mapping->end <=3D cluster_num)
-		mapping =3D find_mapping_for_cluster(s, cluster_num);
+        if (s->qcow) {
+            if (!copy_it && cluster_was_modified(s, cluster_num)) {
+                if (mapping =3D=3D NULL ||
+                        mapping->begin > cluster_num ||
+                        mapping->end <=3D cluster_num)
+                mapping =3D find_mapping_for_cluster(s, cluster_num);
=20
=20
-		if (mapping &&
-			(mapping->mode & MODE_DIRECTORY) =3D=3D 0) {
+                if (mapping &&
+                        (mapping->mode & MODE_DIRECTORY) =3D=3D 0) {
=20
-		    /* was modified in qcow */
-		    if (offset !=3D mapping->info.file.offset + s->cluster_size
-			    * (cluster_num - mapping->begin)) {
-			/* offset of this cluster in file chain has changed */
+                    /* was modified in qcow */
+                    if (offset !=3D mapping->info.file.offset + s->clust=
er_size
+                            * (cluster_num - mapping->begin)) {
+                        /* offset of this cluster in file chain has chan=
ged */
                         abort();
-			copy_it =3D 1;
-		    } else if (offset =3D=3D 0) {
-			const char* basename =3D get_basename(mapping->path);
+                        copy_it =3D 1;
+                    } else if (offset =3D=3D 0) {
+                        const char* basename =3D get_basename(mapping->p=
ath);
=20
-			if (strcmp(basename, basename2))
-			    copy_it =3D 1;
-			first_mapping_index =3D array_index(&(s->mapping), mapping);
-		    }
+                        if (strcmp(basename, basename2))
+                            copy_it =3D 1;
+                        first_mapping_index =3D array_index(&(s->mapping=
), mapping);
+                    }
=20
-		    if (mapping->first_mapping_index !=3D first_mapping_index
-			    && mapping->info.file.offset > 0) {
+                    if (mapping->first_mapping_index !=3D first_mapping_=
index
+                            && mapping->info.file.offset > 0) {
                         abort();
-			copy_it =3D 1;
-		    }
-
-		    /* need to write out? */
-		    if (!was_modified && is_file(direntry)) {
-			was_modified =3D 1;
-			schedule_writeout(s, mapping->dir_index, offset);
-		    }
-		}
-	    }
-
-	    if (copy_it) {
-		int i, dummy;
-		/*
-		 * This is horribly inefficient, but that is okay, since
-		 * it is rarely executed, if at all.
-		 */
-		int64_t offset =3D cluster2sector(s, cluster_num);
-
-		vvfat_close_current_file(s);
+                        copy_it =3D 1;
+                    }
+
+                    /* need to write out? */
+                    if (!was_modified && is_file(direntry)) {
+                        was_modified =3D 1;
+                        schedule_writeout(s, mapping->dir_index, offset)=
;
+                    }
+                }
+            }
+
+            if (copy_it) {
+                int i, dummy;
+                /*
+                 * This is horribly inefficient, but that is okay, since
+                 * it is rarely executed, if at all.
+                 */
+                int64_t offset =3D cluster2sector(s, cluster_num);
+
+                vvfat_close_current_file(s);
                 for (i =3D 0; i < s->sectors_per_cluster; i++) {
                     int res;
=20
@@ -1870,22 +1870,22 @@ static uint32_t get_cluster_count_for_direntry(BD=
RVVVFATState* s,
                         }
                     }
                 }
-	    }
-	}
+            }
+        }
=20
-	ret++;
-	if (s->used_clusters[cluster_num] & USED_ANY)
-	    return 0;
-	s->used_clusters[cluster_num] =3D USED_FILE;
+        ret++;
+        if (s->used_clusters[cluster_num] & USED_ANY)
+            return 0;
+        s->used_clusters[cluster_num] =3D USED_FILE;
=20
-	cluster_num =3D modified_fat_get(s, cluster_num);
+        cluster_num =3D modified_fat_get(s, cluster_num);
=20
-	if (fat_eof(s, cluster_num))
-	    return ret;
-	else if (cluster_num < 2 || cluster_num > s->max_fat_value - 16)
-	    return -1;
+        if (fat_eof(s, cluster_num))
+            return ret;
+        else if (cluster_num < 2 || cluster_num > s->max_fat_value - 16)
+            return -1;
=20
-	offset +=3D s->cluster_size;
+        offset +=3D s->cluster_size;
     }
 }
=20
@@ -1895,7 +1895,7 @@ static uint32_t get_cluster_count_for_direntry(BDRV=
VVFATState* s,
  * used by the directory, its subdirectories and their files.
  */
 static int check_directory_consistency(BDRVVVFATState *s,
-	int cluster_num, const char* path)
+        int cluster_num, const char* path)
 {
     int ret =3D 0;
     unsigned char* cluster =3D g_malloc(s->cluster_size);
@@ -1912,104 +1912,104 @@ static int check_directory_consistency(BDRVVVFA=
TState *s,
     path2[path_len + 1] =3D '\0';
=20
     if (mapping) {
-	const char* basename =3D get_basename(mapping->path);
-	const char* basename2 =3D get_basename(path);
+        const char* basename =3D get_basename(mapping->path);
+        const char* basename2 =3D get_basename(path);
=20
-	assert(mapping->mode & MODE_DIRECTORY);
+        assert(mapping->mode & MODE_DIRECTORY);
=20
-	assert(mapping->mode & MODE_DELETED);
-	mapping->mode &=3D ~MODE_DELETED;
+        assert(mapping->mode & MODE_DELETED);
+        mapping->mode &=3D ~MODE_DELETED;
=20
-	if (strcmp(basename, basename2))
-	    schedule_rename(s, cluster_num, g_strdup(path));
+        if (strcmp(basename, basename2))
+            schedule_rename(s, cluster_num, g_strdup(path));
     } else
-	/* new directory */
-	schedule_mkdir(s, cluster_num, g_strdup(path));
+        /* new directory */
+        schedule_mkdir(s, cluster_num, g_strdup(path));
=20
     lfn_init(&lfn);
     do {
-	int i;
-	int subret =3D 0;
+        int i;
+        int subret =3D 0;
=20
-	ret++;
+        ret++;
=20
-	if (s->used_clusters[cluster_num] & USED_ANY) {
-	    fprintf(stderr, "cluster %d used more than once\n", (int)cluster_nu=
m);
+        if (s->used_clusters[cluster_num] & USED_ANY) {
+            fprintf(stderr, "cluster %d used more than once\n", (int)clu=
ster_num);
             goto fail;
-	}
-	s->used_clusters[cluster_num] =3D USED_DIRECTORY;
+        }
+        s->used_clusters[cluster_num] =3D USED_DIRECTORY;
=20
 DLOG(fprintf(stderr, "read cluster %d (sector %d)\n", (int)cluster_num, =
(int)cluster2sector(s, cluster_num)));
-	subret =3D vvfat_read(s->bs, cluster2sector(s, cluster_num), cluster,
-		s->sectors_per_cluster);
-	if (subret) {
-	    fprintf(stderr, "Error fetching direntries\n");
-	fail:
+        subret =3D vvfat_read(s->bs, cluster2sector(s, cluster_num), clu=
ster,
+                s->sectors_per_cluster);
+        if (subret) {
+            fprintf(stderr, "Error fetching direntries\n");
+        fail:
             g_free(cluster);
-	    return 0;
-	}
+            return 0;
+        }
=20
-	for (i =3D 0; i < 0x10 * s->sectors_per_cluster; i++) {
-	    int cluster_count =3D 0;
+        for (i =3D 0; i < 0x10 * s->sectors_per_cluster; i++) {
+            int cluster_count =3D 0;
=20
 DLOG(fprintf(stderr, "check direntry %d:\n", i); print_direntry(direntri=
es + i));
-	    if (is_volume_label(direntries + i) || is_dot(direntries + i) ||
-		    is_free(direntries + i))
-		continue;
-
-	    subret =3D parse_long_name(&lfn, direntries + i);
-	    if (subret < 0) {
-		fprintf(stderr, "Error in long name\n");
-		goto fail;
-	    }
-	    if (subret =3D=3D 0 || is_free(direntries + i))
-		continue;
-
-	    if (fat_chksum(direntries+i) !=3D lfn.checksum) {
-		subret =3D parse_short_name(s, &lfn, direntries + i);
-		if (subret < 0) {
-		    fprintf(stderr, "Error in short name (%d)\n", subret);
-		    goto fail;
-		}
-		if (subret > 0 || !strcmp((char*)lfn.name, ".")
-			|| !strcmp((char*)lfn.name, ".."))
-		    continue;
-	    }
-	    lfn.checksum =3D 0x100; /* cannot use long name twice */
-
-	    if (path_len + 1 + lfn.len >=3D PATH_MAX) {
-		fprintf(stderr, "Name too long: %s/%s\n", path, lfn.name);
-		goto fail;
-	    }
+            if (is_volume_label(direntries + i) || is_dot(direntries + i=
) ||
+                    is_free(direntries + i))
+                continue;
+
+            subret =3D parse_long_name(&lfn, direntries + i);
+            if (subret < 0) {
+                fprintf(stderr, "Error in long name\n");
+                goto fail;
+            }
+            if (subret =3D=3D 0 || is_free(direntries + i))
+                continue;
+
+            if (fat_chksum(direntries+i) !=3D lfn.checksum) {
+                subret =3D parse_short_name(s, &lfn, direntries + i);
+                if (subret < 0) {
+                    fprintf(stderr, "Error in short name (%d)\n", subret=
);
+                    goto fail;
+                }
+                if (subret > 0 || !strcmp((char*)lfn.name, ".")
+                        || !strcmp((char*)lfn.name, ".."))
+                    continue;
+            }
+            lfn.checksum =3D 0x100; /* cannot use long name twice */
+
+            if (path_len + 1 + lfn.len >=3D PATH_MAX) {
+                fprintf(stderr, "Name too long: %s/%s\n", path, lfn.name=
);
+                goto fail;
+            }
             pstrcpy(path2 + path_len + 1, sizeof(path2) - path_len - 1,
                     (char*)lfn.name);
=20
-	    if (is_directory(direntries + i)) {
-		if (begin_of_direntry(direntries + i) =3D=3D 0) {
-		    DLOG(fprintf(stderr, "invalid begin for directory: %s\n", path2); =
print_direntry(direntries + i));
-		    goto fail;
-		}
-		cluster_count =3D check_directory_consistency(s,
-			begin_of_direntry(direntries + i), path2);
-		if (cluster_count =3D=3D 0) {
-		    DLOG(fprintf(stderr, "problem in directory %s:\n", path2); print_d=
irentry(direntries + i));
-		    goto fail;
-		}
-	    } else if (is_file(direntries + i)) {
-		/* check file size with FAT */
-		cluster_count =3D get_cluster_count_for_direntry(s, direntries + i, pa=
th2);
-		if (cluster_count !=3D
+            if (is_directory(direntries + i)) {
+                if (begin_of_direntry(direntries + i) =3D=3D 0) {
+                    DLOG(fprintf(stderr, "invalid begin for directory: %=
s\n", path2); print_direntry(direntries + i));
+                    goto fail;
+                }
+                cluster_count =3D check_directory_consistency(s,
+                        begin_of_direntry(direntries + i), path2);
+                if (cluster_count =3D=3D 0) {
+                    DLOG(fprintf(stderr, "problem in directory %s:\n", p=
ath2); print_direntry(direntries + i));
+                    goto fail;
+                }
+            } else if (is_file(direntries + i)) {
+                /* check file size with FAT */
+                cluster_count =3D get_cluster_count_for_direntry(s, dire=
ntries + i, path2);
+                if (cluster_count !=3D
             DIV_ROUND_UP(le32_to_cpu(direntries[i].size), s->cluster_siz=
e)) {
-		    DLOG(fprintf(stderr, "Cluster count mismatch\n"));
-		    goto fail;
-		}
-	    } else
+                    DLOG(fprintf(stderr, "Cluster count mismatch\n"));
+                    goto fail;
+                }
+            } else
                 abort(); /* cluster_count =3D 0; */
=20
-	    ret +=3D cluster_count;
-	}
+            ret +=3D cluster_count;
+        }
=20
-	cluster_num =3D modified_fat_get(s, cluster_num);
+        cluster_num =3D modified_fat_get(s, cluster_num);
     } while(!fat_eof(s, cluster_num));
=20
     g_free(cluster);
@@ -2037,81 +2037,81 @@ DLOG(checkpoint());
      * - if all is fine, return number of used clusters
      */
     if (s->fat2 =3D=3D NULL) {
-	int size =3D 0x200 * s->sectors_per_fat;
-	s->fat2 =3D g_malloc(size);
-	memcpy(s->fat2, s->fat.pointer, size);
+        int size =3D 0x200 * s->sectors_per_fat;
+        s->fat2 =3D g_malloc(size);
+        memcpy(s->fat2, s->fat.pointer, size);
     }
     check =3D vvfat_read(s->bs,
-	    s->first_sectors_number, s->fat2, s->sectors_per_fat);
+            s->first_sectors_number, s->fat2, s->sectors_per_fat);
     if (check) {
-	fprintf(stderr, "Could not copy fat\n");
-	return 0;
+        fprintf(stderr, "Could not copy fat\n");
+        return 0;
     }
     assert (s->used_clusters);
     for (i =3D 0; i < sector2cluster(s, s->sector_count); i++)
-	s->used_clusters[i] &=3D ~USED_ANY;
+        s->used_clusters[i] &=3D ~USED_ANY;
=20
     clear_commits(s);
=20
     /* mark every mapped file/directory as deleted.
      * (check_directory_consistency() will unmark those still present). =
*/
     if (s->qcow)
-	for (i =3D 0; i < s->mapping.next; i++) {
-	    mapping_t* mapping =3D array_get(&(s->mapping), i);
-	    if (mapping->first_mapping_index < 0)
-		mapping->mode |=3D MODE_DELETED;
-	}
+        for (i =3D 0; i < s->mapping.next; i++) {
+            mapping_t* mapping =3D array_get(&(s->mapping), i);
+            if (mapping->first_mapping_index < 0)
+                mapping->mode |=3D MODE_DELETED;
+        }
=20
     used_clusters_count =3D check_directory_consistency(s, 0, s->path);
     if (used_clusters_count <=3D 0) {
-	DLOG(fprintf(stderr, "problem in directory\n"));
-	return 0;
+        DLOG(fprintf(stderr, "problem in directory\n"));
+        return 0;
     }
=20
     check =3D s->last_cluster_of_root_directory;
     for (i =3D check; i < sector2cluster(s, s->sector_count); i++) {
-	if (modified_fat_get(s, i)) {
-	    if(!s->used_clusters[i]) {
-		DLOG(fprintf(stderr, "FAT was modified (%d), but cluster is not used?\=
n", i));
-		return 0;
-	    }
-	    check++;
-	}
+        if (modified_fat_get(s, i)) {
+            if(!s->used_clusters[i]) {
+                DLOG(fprintf(stderr, "FAT was modified (%d), but cluster=
 is not used?\n", i));
+                return 0;
+            }
+            check++;
+        }
=20
-	if (s->used_clusters[i] =3D=3D USED_ALLOCATED) {
-	    /* allocated, but not used... */
-	    DLOG(fprintf(stderr, "unused, modified cluster: %d\n", i));
-	    return 0;
-	}
+        if (s->used_clusters[i] =3D=3D USED_ALLOCATED) {
+            /* allocated, but not used... */
+            DLOG(fprintf(stderr, "unused, modified cluster: %d\n", i));
+            return 0;
+        }
     }
=20
     if (check !=3D used_clusters_count)
-	return 0;
+        return 0;
=20
     return used_clusters_count;
 }
=20
 static inline void adjust_mapping_indices(BDRVVVFATState* s,
-	int offset, int adjust)
+        int offset, int adjust)
 {
     int i;
=20
     for (i =3D 0; i < s->mapping.next; i++) {
-	mapping_t* mapping =3D array_get(&(s->mapping), i);
+        mapping_t* mapping =3D array_get(&(s->mapping), i);
=20
 #define ADJUST_MAPPING_INDEX(name) \
-	if (mapping->name >=3D offset) \
-	    mapping->name +=3D adjust
+        if (mapping->name >=3D offset) \
+            mapping->name +=3D adjust
=20
-	ADJUST_MAPPING_INDEX(first_mapping_index);
-	if (mapping->mode & MODE_DIRECTORY)
-	    ADJUST_MAPPING_INDEX(info.dir.parent_mapping_index);
+        ADJUST_MAPPING_INDEX(first_mapping_index);
+        if (mapping->mode & MODE_DIRECTORY)
+            ADJUST_MAPPING_INDEX(info.dir.parent_mapping_index);
     }
 }
=20
 /* insert or update mapping */
 static mapping_t* insert_mapping(BDRVVVFATState* s,
-	uint32_t begin, uint32_t end)
+        uint32_t begin, uint32_t end)
 {
     /*
      * - find mapping where mapping->begin >=3D begin,
@@ -2125,15 +2125,15 @@ static mapping_t* insert_mapping(BDRVVVFATState* =
s,
     mapping_t* first_mapping =3D array_get(&(s->mapping), 0);
=20
     if (index < s->mapping.next && (mapping =3D array_get(&(s->mapping),=
 index))
-	    && mapping->begin < begin) {
-	mapping->end =3D begin;
-	index++;
-	mapping =3D array_get(&(s->mapping), index);
+            && mapping->begin < begin) {
+        mapping->end =3D begin;
+        index++;
+        mapping =3D array_get(&(s->mapping), index);
     }
     if (index >=3D s->mapping.next || mapping->begin > begin) {
-	mapping =3D array_insert(&(s->mapping), index, 1);
-	mapping->path =3D NULL;
-	adjust_mapping_indices(s, index, +1);
+        mapping =3D array_insert(&(s->mapping), index, 1);
+        mapping->path =3D NULL;
+        adjust_mapping_indices(s, index, +1);
     }
=20
     mapping->begin =3D begin;
@@ -2145,8 +2145,8 @@ assert(index + 1 >=3D s->mapping.next ||
  next_mapping->begin >=3D end)));
=20
     if (s->current_mapping && first_mapping !=3D (mapping_t*)s->mapping.=
pointer)
-	s->current_mapping =3D array_get(&(s->mapping),
-		s->current_mapping - first_mapping);
+        s->current_mapping =3D array_get(&(s->mapping),
+                s->current_mapping - first_mapping);
=20
     return mapping;
 }
@@ -2168,8 +2168,8 @@ static int remove_mapping(BDRVVVFATState* s, int ma=
pping_index)
     adjust_mapping_indices(s, mapping_index, -1);
=20
     if (s->current_mapping && first_mapping !=3D (mapping_t*)s->mapping.=
pointer)
-	s->current_mapping =3D array_get(&(s->mapping),
-		s->current_mapping - first_mapping);
+        s->current_mapping =3D array_get(&(s->mapping),
+                s->current_mapping - first_mapping);
=20
     return 0;
 }
@@ -2178,17 +2178,17 @@ static void adjust_dirindices(BDRVVVFATState* s, =
int offset, int adjust)
 {
     int i;
     for (i =3D 0; i < s->mapping.next; i++) {
-	mapping_t* mapping =3D array_get(&(s->mapping), i);
-	if (mapping->dir_index >=3D offset)
-	    mapping->dir_index +=3D adjust;
-	if ((mapping->mode & MODE_DIRECTORY) &&
-		mapping->info.dir.first_dir_index >=3D offset)
-	    mapping->info.dir.first_dir_index +=3D adjust;
+        mapping_t* mapping =3D array_get(&(s->mapping), i);
+        if (mapping->dir_index >=3D offset)
+            mapping->dir_index +=3D adjust;
+        if ((mapping->mode & MODE_DIRECTORY) &&
+                mapping->info.dir.first_dir_index >=3D offset)
+            mapping->info.dir.first_dir_index +=3D adjust;
     }
 }
=20
 static direntry_t* insert_direntries(BDRVVVFATState* s,
-	int dir_index, int count)
+        int dir_index, int count)
 {
     /*
      * make room in s->directory,
@@ -2196,7 +2196,7 @@ static direntry_t* insert_direntries(BDRVVVFATState=
* s,
      */
     direntry_t* result =3D array_insert(&(s->directory), dir_index, coun=
t);
     if (result =3D=3D NULL)
-	return NULL;
+        return NULL;
     adjust_dirindices(s, dir_index, count);
     return result;
 }
@@ -2205,7 +2205,7 @@ static int remove_direntries(BDRVVVFATState* s, int=
 dir_index, int count)
 {
     int ret =3D array_remove_slice(&(s->directory), dir_index, count);
     if (ret)
-	return ret;
+        return ret;
     adjust_dirindices(s, dir_index, -count);
     return 0;
 }
@@ -2217,7 +2217,7 @@ static int remove_direntries(BDRVVVFATState* s, int=
 dir_index, int count)
  * adjusted)
  */
 static int commit_mappings(BDRVVVFATState* s,
-	uint32_t first_cluster, int dir_index)
+        uint32_t first_cluster, int dir_index)
 {
     mapping_t* mapping =3D find_mapping_for_cluster(s, first_cluster);
     direntry_t* direntry =3D array_get(&(s->directory), dir_index);
@@ -2230,71 +2230,71 @@ static int commit_mappings(BDRVVVFATState* s,
     mapping->first_mapping_index =3D -1;
     mapping->dir_index =3D dir_index;
     mapping->mode =3D (dir_index <=3D 0 || is_directory(direntry)) ?
-	MODE_DIRECTORY : MODE_NORMAL;
+        MODE_DIRECTORY : MODE_NORMAL;
=20
     while (!fat_eof(s, cluster)) {
-	uint32_t c, c1;
-
-	for (c =3D cluster, c1 =3D modified_fat_get(s, c); c + 1 =3D=3D c1;
-		c =3D c1, c1 =3D modified_fat_get(s, c1));
-
-	c++;
-	if (c > mapping->end) {
-	    int index =3D array_index(&(s->mapping), mapping);
-	    int i, max_i =3D s->mapping.next - index;
-	    for (i =3D 1; i < max_i && mapping[i].begin < c; i++);
-	    while (--i > 0)
-		remove_mapping(s, index + 1);
-	}
-	assert(mapping =3D=3D array_get(&(s->mapping), s->mapping.next - 1)
-		|| mapping[1].begin >=3D c);
-	mapping->end =3D c;
-
-	if (!fat_eof(s, c1)) {
-	    int i =3D find_mapping_for_cluster_aux(s, c1, 0, s->mapping.next);
-	    mapping_t* next_mapping =3D i >=3D s->mapping.next ? NULL :
-		array_get(&(s->mapping), i);
-
-	    if (next_mapping =3D=3D NULL || next_mapping->begin > c1) {
-		int i1 =3D array_index(&(s->mapping), mapping);
-
-		next_mapping =3D insert_mapping(s, c1, c1+1);
-
-		if (c1 < c)
-		    i1++;
-		mapping =3D array_get(&(s->mapping), i1);
-	    }
-
-	    next_mapping->dir_index =3D mapping->dir_index;
-	    next_mapping->first_mapping_index =3D
-		mapping->first_mapping_index < 0 ?
-		array_index(&(s->mapping), mapping) :
-		mapping->first_mapping_index;
-	    next_mapping->path =3D mapping->path;
-	    next_mapping->mode =3D mapping->mode;
-	    next_mapping->read_only =3D mapping->read_only;
-	    if (mapping->mode & MODE_DIRECTORY) {
-		next_mapping->info.dir.parent_mapping_index =3D
-			mapping->info.dir.parent_mapping_index;
-		next_mapping->info.dir.first_dir_index =3D
-			mapping->info.dir.first_dir_index +
-			0x10 * s->sectors_per_cluster *
-			(mapping->end - mapping->begin);
-	    } else
-		next_mapping->info.file.offset =3D mapping->info.file.offset +
-			mapping->end - mapping->begin;
-
-	    mapping =3D next_mapping;
-	}
-
-	cluster =3D c1;
+        uint32_t c, c1;
+
+        for (c =3D cluster, c1 =3D modified_fat_get(s, c); c + 1 =3D=3D =
c1;
+                c =3D c1, c1 =3D modified_fat_get(s, c1));
+
+        c++;
+        if (c > mapping->end) {
+            int index =3D array_index(&(s->mapping), mapping);
+            int i, max_i =3D s->mapping.next - index;
+            for (i =3D 1; i < max_i && mapping[i].begin < c; i++);
+            while (--i > 0)
+                remove_mapping(s, index + 1);
+        }
+        assert(mapping =3D=3D array_get(&(s->mapping), s->mapping.next -=
 1)
+                || mapping[1].begin >=3D c);
+        mapping->end =3D c;
+
+        if (!fat_eof(s, c1)) {
+            int i =3D find_mapping_for_cluster_aux(s, c1, 0, s->mapping.=
next);
+            mapping_t* next_mapping =3D i >=3D s->mapping.next ? NULL :
+                array_get(&(s->mapping), i);
+
+            if (next_mapping =3D=3D NULL || next_mapping->begin > c1) {
+                int i1 =3D array_index(&(s->mapping), mapping);
+
+                next_mapping =3D insert_mapping(s, c1, c1+1);
+
+                if (c1 < c)
+                    i1++;
+                mapping =3D array_get(&(s->mapping), i1);
+            }
+
+            next_mapping->dir_index =3D mapping->dir_index;
+            next_mapping->first_mapping_index =3D
+                mapping->first_mapping_index < 0 ?
+                array_index(&(s->mapping), mapping) :
+                mapping->first_mapping_index;
+            next_mapping->path =3D mapping->path;
+            next_mapping->mode =3D mapping->mode;
+            next_mapping->read_only =3D mapping->read_only;
+            if (mapping->mode & MODE_DIRECTORY) {
+                next_mapping->info.dir.parent_mapping_index =3D
+                        mapping->info.dir.parent_mapping_index;
+                next_mapping->info.dir.first_dir_index =3D
+                        mapping->info.dir.first_dir_index +
+                        0x10 * s->sectors_per_cluster *
+                        (mapping->end - mapping->begin);
+            } else
+                next_mapping->info.file.offset =3D mapping->info.file.of=
fset +
+                        mapping->end - mapping->begin;
+
+            mapping =3D next_mapping;
+        }
+
+        cluster =3D c1;
     }
=20
     return 0;
 }
=20
 static int commit_direntries(BDRVVVFATState* s,
-	int dir_index, int parent_mapping_index)
+        int dir_index, int parent_mapping_index)
 {
     direntry_t* direntry =3D array_get(&(s->directory), dir_index);
     uint32_t first_cluster =3D dir_index =3D=3D 0 ? 0 : begin_of_direntr=
y(direntry);
@@ -2319,58 +2319,58 @@ DLOG(fprintf(stderr, "commit_direntries for %s, p=
arent_mapping_index %d\n", mapp
     mapping->info.dir.parent_mapping_index =3D parent_mapping_index;
=20
     if (first_cluster =3D=3D 0) {
-	old_cluster_count =3D new_cluster_count =3D
-	    s->last_cluster_of_root_directory;
+        old_cluster_count =3D new_cluster_count =3D
+            s->last_cluster_of_root_directory;
     } else {
-	for (old_cluster_count =3D 0, c =3D first_cluster; !fat_eof(s, c);
-		c =3D fat_get(s, c))
-	    old_cluster_count++;
+        for (old_cluster_count =3D 0, c =3D first_cluster; !fat_eof(s, c=
);
+                c =3D fat_get(s, c))
+            old_cluster_count++;
=20
-	for (new_cluster_count =3D 0, c =3D first_cluster; !fat_eof(s, c);
-		c =3D modified_fat_get(s, c))
-	    new_cluster_count++;
+        for (new_cluster_count =3D 0, c =3D first_cluster; !fat_eof(s, c=
);
+                c =3D modified_fat_get(s, c))
+            new_cluster_count++;
     }
=20
     if (new_cluster_count > old_cluster_count) {
-	if (insert_direntries(s,
-		current_dir_index + factor * old_cluster_count,
-		factor * (new_cluster_count - old_cluster_count)) =3D=3D NULL)
-	    return -1;
+        if (insert_direntries(s,
+                current_dir_index + factor * old_cluster_count,
+                factor * (new_cluster_count - old_cluster_count)) =3D=3D=
 NULL)
+            return -1;
     } else if (new_cluster_count < old_cluster_count)
-	remove_direntries(s,
-		current_dir_index + factor * new_cluster_count,
-		factor * (old_cluster_count - new_cluster_count));
+        remove_direntries(s,
+                current_dir_index + factor * new_cluster_count,
+                factor * (old_cluster_count - new_cluster_count));
=20
     for (c =3D first_cluster; !fat_eof(s, c); c =3D modified_fat_get(s, =
c)) {
         direntry_t *first_direntry;
-	void* direntry =3D array_get(&(s->directory), current_dir_index);
-	int ret =3D vvfat_read(s->bs, cluster2sector(s, c), direntry,
-		s->sectors_per_cluster);
-	if (ret)
-	    return ret;
+        void* direntry =3D array_get(&(s->directory), current_dir_index)=
;
+        int ret =3D vvfat_read(s->bs, cluster2sector(s, c), direntry,
+                s->sectors_per_cluster);
+        if (ret)
+            return ret;
=20
         /* The first directory entry on the filesystem is the volume nam=
e */
         first_direntry =3D (direntry_t*) s->directory.pointer;
         assert(!memcmp(first_direntry->name, s->volume_label, 11));
=20
-	current_dir_index +=3D factor;
+        current_dir_index +=3D factor;
     }
=20
     ret =3D commit_mappings(s, first_cluster, dir_index);
     if (ret)
-	return ret;
+        return ret;
=20
     /* recurse */
     for (i =3D 0; i < factor * new_cluster_count; i++) {
-	direntry =3D array_get(&(s->directory), first_dir_index + i);
-	if (is_directory(direntry) && !is_dot(direntry)) {
-	    mapping =3D find_mapping_for_cluster(s, first_cluster);
-	    assert(mapping->mode & MODE_DIRECTORY);
-	    ret =3D commit_direntries(s, first_dir_index + i,
-		array_index(&(s->mapping), mapping));
-	    if (ret)
-		return ret;
-	}
+        direntry =3D array_get(&(s->directory), first_dir_index + i);
+        if (is_directory(direntry) && !is_dot(direntry)) {
+            mapping =3D find_mapping_for_cluster(s, first_cluster);
+            assert(mapping->mode & MODE_DIRECTORY);
+            ret =3D commit_direntries(s, first_dir_index + i,
+                array_index(&(s->mapping), mapping));
+            if (ret)
+                return ret;
+        }
     }
=20
     return 0;
@@ -2379,7 +2379,7 @@ DLOG(fprintf(stderr, "commit_direntries for %s, par=
ent_mapping_index %d\n", mapp
 /* commit one file (adjust contents, adjust mapping),
    return first_mapping_index */
 static int commit_one_file(BDRVVVFATState* s,
-	int dir_index, uint32_t offset)
+        int dir_index, uint32_t offset)
 {
     direntry_t* direntry =3D array_get(&(s->directory), dir_index);
     uint32_t c =3D begin_of_direntry(direntry);
@@ -2394,14 +2394,14 @@ static int commit_one_file(BDRVVVFATState* s,
     assert((offset % s->cluster_size) =3D=3D 0);
=20
     for (i =3D s->cluster_size; i < offset; i +=3D s->cluster_size)
-	c =3D modified_fat_get(s, c);
+        c =3D modified_fat_get(s, c);
=20
     fd =3D qemu_open(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
     if (fd < 0) {
-	fprintf(stderr, "Could not open %s... (%s, %d)\n", mapping->path,
-		strerror(errno), errno);
+        fprintf(stderr, "Could not open %s... (%s, %d)\n", mapping->path=
,
+                strerror(errno), errno);
         g_free(cluster);
-	return fd;
+        return fd;
     }
     if (offset > 0) {
         if (lseek(fd, offset, SEEK_SET) !=3D offset) {
@@ -2412,18 +2412,18 @@ static int commit_one_file(BDRVVVFATState* s,
     }
=20
     while (offset < size) {
-	uint32_t c1;
-	int rest_size =3D (size - offset > s->cluster_size ?
-		s->cluster_size : size - offset);
-	int ret;
+        uint32_t c1;
+        int rest_size =3D (size - offset > s->cluster_size ?
+                s->cluster_size : size - offset);
+        int ret;
=20
-	c1 =3D modified_fat_get(s, c);
+        c1 =3D modified_fat_get(s, c);
=20
-	assert((size - offset =3D=3D 0 && fat_eof(s, c)) ||
-		(size > offset && c >=3D2 && !fat_eof(s, c)));
+        assert((size - offset =3D=3D 0 && fat_eof(s, c)) ||
+                (size > offset && c >=3D2 && !fat_eof(s, c)));
=20
-	ret =3D vvfat_read(s->bs, cluster2sector(s, c),
-	    (uint8_t*)cluster, (rest_size + 0x1ff) / 0x200);
+        ret =3D vvfat_read(s->bs, cluster2sector(s, c),
+            (uint8_t*)cluster, (rest_size + 0x1ff) / 0x200);
=20
         if (ret < 0) {
             qemu_close(fd);
@@ -2437,8 +2437,8 @@ static int commit_one_file(BDRVVVFATState* s,
             return -2;
         }
=20
-	offset +=3D rest_size;
-	c =3D c1;
+        offset +=3D rest_size;
+        c =3D c1;
     }
=20
     if (ftruncate(fd, size)) {
@@ -2459,18 +2459,18 @@ static void check1(BDRVVVFATState* s)
 {
     int i;
     for (i =3D 0; i < s->mapping.next; i++) {
-	mapping_t* mapping =3D array_get(&(s->mapping), i);
-	if (mapping->mode & MODE_DELETED) {
-	    fprintf(stderr, "deleted\n");
-	    continue;
-	}
-	assert(mapping->dir_index < s->directory.next);
-	direntry_t* direntry =3D array_get(&(s->directory), mapping->dir_index)=
;
-	assert(mapping->begin =3D=3D begin_of_direntry(direntry) || mapping->fi=
rst_mapping_index >=3D 0);
-	if (mapping->mode & MODE_DIRECTORY) {
-	    assert(mapping->info.dir.first_dir_index + 0x10 * s->sectors_per_cl=
uster * (mapping->end - mapping->begin) <=3D s->directory.next);
-	    assert((mapping->info.dir.first_dir_index % (0x10 * s->sectors_per_=
cluster)) =3D=3D 0);
-	}
+        mapping_t* mapping =3D array_get(&(s->mapping), i);
+        if (mapping->mode & MODE_DELETED) {
+            fprintf(stderr, "deleted\n");
+            continue;
+        }
+        assert(mapping->dir_index < s->directory.next);
+        direntry_t* direntry =3D array_get(&(s->directory), mapping->dir=
_index);
+        assert(mapping->begin =3D=3D begin_of_direntry(direntry) || mapp=
ing->first_mapping_index >=3D 0);
+        if (mapping->mode & MODE_DIRECTORY) {
+            assert(mapping->info.dir.first_dir_index + 0x10 * s->sectors=
_per_cluster * (mapping->end - mapping->begin) <=3D s->directory.next);
+            assert((mapping->info.dir.first_dir_index % (0x10 * s->secto=
rs_per_cluster)) =3D=3D 0);
+        }
     }
 }
=20
@@ -2481,43 +2481,43 @@ static void check2(BDRVVVFATState* s)
     int first_mapping =3D -1;
=20
     for (i =3D 0; i < s->directory.next; i++) {
-	direntry_t* direntry =3D array_get(&(s->directory), i);
-
-	if (is_short_name(direntry) && begin_of_direntry(direntry)) {
-	    mapping_t* mapping =3D find_mapping_for_cluster(s, begin_of_direntr=
y(direntry));
-	    assert(mapping);
-	    assert(mapping->dir_index =3D=3D i || is_dot(direntry));
-	    assert(mapping->begin =3D=3D begin_of_direntry(direntry) || is_dot(=
direntry));
-	}
-
-	if ((i % (0x10 * s->sectors_per_cluster)) =3D=3D 0) {
-	    /* cluster start */
-	    int j, count =3D 0;
-
-	    for (j =3D 0; j < s->mapping.next; j++) {
-		mapping_t* mapping =3D array_get(&(s->mapping), j);
-		if (mapping->mode & MODE_DELETED)
-		    continue;
-		if (mapping->mode & MODE_DIRECTORY) {
-		    if (mapping->info.dir.first_dir_index <=3D i && mapping->info.dir.=
first_dir_index + 0x10 * s->sectors_per_cluster > i) {
-			assert(++count =3D=3D 1);
-			if (mapping->first_mapping_index =3D=3D -1)
-			    first_mapping =3D array_index(&(s->mapping), mapping);
-			else
-			    assert(first_mapping =3D=3D mapping->first_mapping_index);
-			if (mapping->info.dir.parent_mapping_index < 0)
-			    assert(j =3D=3D 0);
-			else {
-			    mapping_t* parent =3D array_get(&(s->mapping), mapping->info.dir.=
parent_mapping_index);
-			    assert(parent->mode & MODE_DIRECTORY);
-			    assert(parent->info.dir.first_dir_index < mapping->info.dir.first=
_dir_index);
-			}
-		    }
-		}
-	    }
-	    if (count =3D=3D 0)
-		first_mapping =3D -1;
-	}
+        direntry_t* direntry =3D array_get(&(s->directory), i);
+
+        if (is_short_name(direntry) && begin_of_direntry(direntry)) {
+            mapping_t* mapping =3D find_mapping_for_cluster(s, begin_of_=
direntry(direntry));
+            assert(mapping);
+            assert(mapping->dir_index =3D=3D i || is_dot(direntry));
+            assert(mapping->begin =3D=3D begin_of_direntry(direntry) || =
is_dot(direntry));
+        }
+
+        if ((i % (0x10 * s->sectors_per_cluster)) =3D=3D 0) {
+            /* cluster start */
+            int j, count =3D 0;
+
+            for (j =3D 0; j < s->mapping.next; j++) {
+                mapping_t* mapping =3D array_get(&(s->mapping), j);
+                if (mapping->mode & MODE_DELETED)
+                    continue;
+                if (mapping->mode & MODE_DIRECTORY) {
+                    if (mapping->info.dir.first_dir_index <=3D i && mapp=
ing->info.dir.first_dir_index + 0x10 * s->sectors_per_cluster > i) {
+                        assert(++count =3D=3D 1);
+                        if (mapping->first_mapping_index =3D=3D -1)
+                            first_mapping =3D array_index(&(s->mapping),=
 mapping);
+                        else
+                            assert(first_mapping =3D=3D mapping->first_m=
apping_index);
+                        if (mapping->info.dir.parent_mapping_index < 0)
+                            assert(j =3D=3D 0);
+                        else {
+                            mapping_t* parent =3D array_get(&(s->mapping=
), mapping->info.dir.parent_mapping_index);
+                            assert(parent->mode & MODE_DIRECTORY);
+                            assert(parent->info.dir.first_dir_index < ma=
pping->info.dir.first_dir_index);
+                        }
+                    }
+                }
+            }
+            if (count =3D=3D 0)
+                first_mapping =3D -1;
+        }
     }
 }
 #endif
@@ -2529,63 +2529,63 @@ static int handle_renames_and_mkdirs(BDRVVVFATSta=
te* s)
 #ifdef DEBUG
     fprintf(stderr, "handle_renames\n");
     for (i =3D 0; i < s->commits.next; i++) {
-	commit_t* commit =3D array_get(&(s->commits), i);
-	fprintf(stderr, "%d, %s (%d, %d)\n", i, commit->path ? commit->path : "=
(null)", commit->param.rename.cluster, commit->action);
+        commit_t* commit =3D array_get(&(s->commits), i);
+        fprintf(stderr, "%d, %s (%d, %d)\n", i, commit->path ? commit->p=
ath : "(null)", commit->param.rename.cluster, commit->action);
     }
 #endif
=20
     for (i =3D 0; i < s->commits.next;) {
-	commit_t* commit =3D array_get(&(s->commits), i);
-	if (commit->action =3D=3D ACTION_RENAME) {
-	    mapping_t* mapping =3D find_mapping_for_cluster(s,
-		    commit->param.rename.cluster);
-	    char* old_path =3D mapping->path;
-
-	    assert(commit->path);
-	    mapping->path =3D commit->path;
-	    if (rename(old_path, mapping->path))
-		return -2;
-
-	    if (mapping->mode & MODE_DIRECTORY) {
-		int l1 =3D strlen(mapping->path);
-		int l2 =3D strlen(old_path);
-		int diff =3D l1 - l2;
-		direntry_t* direntry =3D array_get(&(s->directory),
-			mapping->info.dir.first_dir_index);
-		uint32_t c =3D mapping->begin;
-		int i =3D 0;
-
-		/* recurse */
-		while (!fat_eof(s, c)) {
-		    do {
-			direntry_t* d =3D direntry + i;
-
-			if (is_file(d) || (is_directory(d) && !is_dot(d))) {
-			    mapping_t* m =3D find_mapping_for_cluster(s,
-				    begin_of_direntry(d));
-			    int l =3D strlen(m->path);
-			    char* new_path =3D g_malloc(l + diff + 1);
-
-			    assert(!strncmp(m->path, mapping->path, l2));
+        commit_t* commit =3D array_get(&(s->commits), i);
+        if (commit->action =3D=3D ACTION_RENAME) {
+            mapping_t* mapping =3D find_mapping_for_cluster(s,
+                    commit->param.rename.cluster);
+            char* old_path =3D mapping->path;
+
+            assert(commit->path);
+            mapping->path =3D commit->path;
+            if (rename(old_path, mapping->path))
+                return -2;
+
+            if (mapping->mode & MODE_DIRECTORY) {
+                int l1 =3D strlen(mapping->path);
+                int l2 =3D strlen(old_path);
+                int diff =3D l1 - l2;
+                direntry_t* direntry =3D array_get(&(s->directory),
+                        mapping->info.dir.first_dir_index);
+                uint32_t c =3D mapping->begin;
+                int i =3D 0;
+
+                /* recurse */
+                while (!fat_eof(s, c)) {
+                    do {
+                        direntry_t* d =3D direntry + i;
+
+                        if (is_file(d) || (is_directory(d) && !is_dot(d)=
)) {
+                            mapping_t* m =3D find_mapping_for_cluster(s,
+                                    begin_of_direntry(d));
+                            int l =3D strlen(m->path);
+                            char* new_path =3D g_malloc(l + diff + 1);
+
+                            assert(!strncmp(m->path, mapping->path, l2))=
;
=20
                             pstrcpy(new_path, l + diff + 1, mapping->pat=
h);
                             pstrcpy(new_path + l1, l + diff + 1 - l1,
                                     m->path + l2);
=20
-			    schedule_rename(s, m->begin, new_path);
-			}
-			i++;
-		    } while((i % (0x10 * s->sectors_per_cluster)) !=3D 0);
-		    c =3D fat_get(s, c);
-		}
-	    }
+                            schedule_rename(s, m->begin, new_path);
+                        }
+                        i++;
+                    } while((i % (0x10 * s->sectors_per_cluster)) !=3D 0=
);
+                    c =3D fat_get(s, c);
+                }
+            }
=20
             g_free(old_path);
-	    array_remove(&(s->commits), i);
-	    continue;
-	} else if (commit->action =3D=3D ACTION_MKDIR) {
-	    mapping_t* mapping;
-	    int j, parent_path_len;
+            array_remove(&(s->commits), i);
+            continue;
+        } else if (commit->action =3D=3D ACTION_MKDIR) {
+            mapping_t* mapping;
+            int j, parent_path_len;
=20
 #ifdef __MINGW32__
             if (mkdir(commit->path))
@@ -2595,37 +2595,37 @@ static int handle_renames_and_mkdirs(BDRVVVFATSta=
te* s)
                 return -5;
 #endif
=20
-	    mapping =3D insert_mapping(s, commit->param.mkdir.cluster,
-		    commit->param.mkdir.cluster + 1);
-	    if (mapping =3D=3D NULL)
-		return -6;
-
-	    mapping->mode =3D MODE_DIRECTORY;
-	    mapping->read_only =3D 0;
-	    mapping->path =3D commit->path;
-	    j =3D s->directory.next;
-	    assert(j);
-	    insert_direntries(s, s->directory.next,
-		    0x10 * s->sectors_per_cluster);
-	    mapping->info.dir.first_dir_index =3D j;
-
-	    parent_path_len =3D strlen(commit->path)
-		- strlen(get_basename(commit->path)) - 1;
-	    for (j =3D 0; j < s->mapping.next; j++) {
-		mapping_t* m =3D array_get(&(s->mapping), j);
-		if (m->first_mapping_index < 0 && m !=3D mapping &&
-			!strncmp(m->path, mapping->path, parent_path_len) &&
-			strlen(m->path) =3D=3D parent_path_len)
-		    break;
-	    }
-	    assert(j < s->mapping.next);
-	    mapping->info.dir.parent_mapping_index =3D j;
-
-	    array_remove(&(s->commits), i);
-	    continue;
-	}
-
-	i++;
+            mapping =3D insert_mapping(s, commit->param.mkdir.cluster,
+                    commit->param.mkdir.cluster + 1);
+            if (mapping =3D=3D NULL)
+                return -6;
+
+            mapping->mode =3D MODE_DIRECTORY;
+            mapping->read_only =3D 0;
+            mapping->path =3D commit->path;
+            j =3D s->directory.next;
+            assert(j);
+            insert_direntries(s, s->directory.next,
+                    0x10 * s->sectors_per_cluster);
+            mapping->info.dir.first_dir_index =3D j;
+
+            parent_path_len =3D strlen(commit->path)
+                - strlen(get_basename(commit->path)) - 1;
+            for (j =3D 0; j < s->mapping.next; j++) {
+                mapping_t* m =3D array_get(&(s->mapping), j);
+                if (m->first_mapping_index < 0 && m !=3D mapping &&
+                        !strncmp(m->path, mapping->path, parent_path_len=
) &&
+                        strlen(m->path) =3D=3D parent_path_len)
+                    break;
+            }
+            assert(j < s->mapping.next);
+            mapping->info.dir.parent_mapping_index =3D j;
+
+            array_remove(&(s->commits), i);
+            continue;
+        }
+
+        i++;
     }
     return 0;
 }
@@ -2640,75 +2640,75 @@ static int handle_commits(BDRVVVFATState* s)
     vvfat_close_current_file(s);
=20
     for (i =3D 0; !fail && i < s->commits.next; i++) {
-	commit_t* commit =3D array_get(&(s->commits), i);
-	switch(commit->action) {
-	case ACTION_RENAME: case ACTION_MKDIR:
+        commit_t* commit =3D array_get(&(s->commits), i);
+        switch(commit->action) {
+        case ACTION_RENAME: case ACTION_MKDIR:
             abort();
-	    fail =3D -2;
-	    break;
-	case ACTION_WRITEOUT: {
+            fail =3D -2;
+            break;
+        case ACTION_WRITEOUT: {
 #ifndef NDEBUG
             /* these variables are only used by assert() below */
-	    direntry_t* entry =3D array_get(&(s->directory),
-		    commit->param.writeout.dir_index);
-	    uint32_t begin =3D begin_of_direntry(entry);
-	    mapping_t* mapping =3D find_mapping_for_cluster(s, begin);
+            direntry_t* entry =3D array_get(&(s->directory),
+                    commit->param.writeout.dir_index);
+            uint32_t begin =3D begin_of_direntry(entry);
+            mapping_t* mapping =3D find_mapping_for_cluster(s, begin);
 #endif
=20
-	    assert(mapping);
-	    assert(mapping->begin =3D=3D begin);
-	    assert(commit->path =3D=3D NULL);
-
-	    if (commit_one_file(s, commit->param.writeout.dir_index,
-			commit->param.writeout.modified_offset))
-		fail =3D -3;
-
-	    break;
-	}
-	case ACTION_NEW_FILE: {
-	    int begin =3D commit->param.new_file.first_cluster;
-	    mapping_t* mapping =3D find_mapping_for_cluster(s, begin);
-	    direntry_t* entry;
-	    int i;
-
-	    /* find direntry */
-	    for (i =3D 0; i < s->directory.next; i++) {
-		entry =3D array_get(&(s->directory), i);
-		if (is_file(entry) && begin_of_direntry(entry) =3D=3D begin)
-		    break;
-	    }
-
-	    if (i >=3D s->directory.next) {
-		fail =3D -6;
-		continue;
-	    }
-
-	    /* make sure there exists an initial mapping */
-	    if (mapping && mapping->begin !=3D begin) {
-		mapping->end =3D begin;
-		mapping =3D NULL;
-	    }
-	    if (mapping =3D=3D NULL) {
-		mapping =3D insert_mapping(s, begin, begin+1);
-	    }
-	    /* most members will be fixed in commit_mappings() */
-	    assert(commit->path);
-	    mapping->path =3D commit->path;
-	    mapping->read_only =3D 0;
-	    mapping->mode =3D MODE_NORMAL;
-	    mapping->info.file.offset =3D 0;
-
-	    if (commit_one_file(s, i, 0))
-		fail =3D -7;
-
-	    break;
-	}
-	default:
+            assert(mapping);
+            assert(mapping->begin =3D=3D begin);
+            assert(commit->path =3D=3D NULL);
+
+            if (commit_one_file(s, commit->param.writeout.dir_index,
+                        commit->param.writeout.modified_offset))
+                fail =3D -3;
+
+            break;
+        }
+        case ACTION_NEW_FILE: {
+            int begin =3D commit->param.new_file.first_cluster;
+            mapping_t* mapping =3D find_mapping_for_cluster(s, begin);
+            direntry_t* entry;
+            int i;
+
+            /* find direntry */
+            for (i =3D 0; i < s->directory.next; i++) {
+                entry =3D array_get(&(s->directory), i);
+                if (is_file(entry) && begin_of_direntry(entry) =3D=3D be=
gin)
+                    break;
+            }
+
+            if (i >=3D s->directory.next) {
+                fail =3D -6;
+                continue;
+            }
+
+            /* make sure there exists an initial mapping */
+            if (mapping && mapping->begin !=3D begin) {
+                mapping->end =3D begin;
+                mapping =3D NULL;
+            }
+            if (mapping =3D=3D NULL) {
+                mapping =3D insert_mapping(s, begin, begin+1);
+            }
+            /* most members will be fixed in commit_mappings() */
+            assert(commit->path);
+            mapping->path =3D commit->path;
+            mapping->read_only =3D 0;
+            mapping->mode =3D MODE_NORMAL;
+            mapping->info.file.offset =3D 0;
+
+            if (commit_one_file(s, i, 0))
+                fail =3D -7;
+
+            break;
+        }
+        default:
             abort();
-	}
+        }
     }
     if (i > 0 && array_remove_slice(&(s->commits), 0, i))
-	return -1;
+        return -1;
     return fail;
 }
=20
@@ -2719,53 +2719,53 @@ static int handle_deletes(BDRVVVFATState* s)
     /* delete files corresponding to mappings marked as deleted */
     /* handle DELETEs and unused mappings (modified_fat_get(s, mapping->=
begin) =3D=3D 0) */
     while (deferred && deleted) {
-	deferred =3D 0;
-	deleted =3D 0;
-
-	for (i =3D 1; i < s->mapping.next; i++) {
-	    mapping_t* mapping =3D array_get(&(s->mapping), i);
-	    if (mapping->mode & MODE_DELETED) {
-		direntry_t* entry =3D array_get(&(s->directory),
-			mapping->dir_index);
-
-		if (is_free(entry)) {
-		    /* remove file/directory */
-		    if (mapping->mode & MODE_DIRECTORY) {
-			int j, next_dir_index =3D s->directory.next,
-			first_dir_index =3D mapping->info.dir.first_dir_index;
-
-			if (rmdir(mapping->path) < 0) {
-			    if (errno =3D=3D ENOTEMPTY) {
-				deferred++;
-				continue;
-			    } else
-				return -5;
-			}
-
-			for (j =3D 1; j < s->mapping.next; j++) {
-			    mapping_t* m =3D array_get(&(s->mapping), j);
-			    if (m->mode & MODE_DIRECTORY &&
-				    m->info.dir.first_dir_index >
-				    first_dir_index &&
-				    m->info.dir.first_dir_index <
-				    next_dir_index)
-				next_dir_index =3D
-				    m->info.dir.first_dir_index;
-			}
-			remove_direntries(s, first_dir_index,
-				next_dir_index - first_dir_index);
-
-			deleted++;
-		    }
-		} else {
-		    if (unlink(mapping->path))
-			return -4;
-		    deleted++;
-		}
-		DLOG(fprintf(stderr, "DELETE (%d)\n", i); print_mapping(mapping); prin=
t_direntry(entry));
-		remove_mapping(s, i);
-	    }
-	}
+        deferred =3D 0;
+        deleted =3D 0;
+
+        for (i =3D 1; i < s->mapping.next; i++) {
+            mapping_t* mapping =3D array_get(&(s->mapping), i);
+            if (mapping->mode & MODE_DELETED) {
+                direntry_t* entry =3D array_get(&(s->directory),
+                        mapping->dir_index);
+
+                if (is_free(entry)) {
+                    /* remove file/directory */
+                    if (mapping->mode & MODE_DIRECTORY) {
+                        int j, next_dir_index =3D s->directory.next,
+                        first_dir_index =3D mapping->info.dir.first_dir_=
index;
+
+                        if (rmdir(mapping->path) < 0) {
+                            if (errno =3D=3D ENOTEMPTY) {
+                                deferred++;
+                                continue;
+                            } else
+                                return -5;
+                        }
+
+                        for (j =3D 1; j < s->mapping.next; j++) {
+                            mapping_t* m =3D array_get(&(s->mapping), j)=
;
+                            if (m->mode & MODE_DIRECTORY &&
+                                    m->info.dir.first_dir_index >
+                                    first_dir_index &&
+                                    m->info.dir.first_dir_index <
+                                    next_dir_index)
+                                next_dir_index =3D
+                                    m->info.dir.first_dir_index;
+                        }
+                        remove_direntries(s, first_dir_index,
+                                next_dir_index - first_dir_index);
+
+                        deleted++;
+                    }
+                } else {
+                    if (unlink(mapping->path))
+                        return -4;
+                    deleted++;
+                }
+                DLOG(fprintf(stderr, "DELETE (%d)\n", i); print_mapping(=
mapping); print_direntry(entry));
+                remove_mapping(s, i);
+            }
+        }
     }
=20
     return 0;
@@ -2785,15 +2785,15 @@ static int do_commit(BDRVVVFATState* s)
=20
     /* the real meat are the commits. Nothing to do? Move along! */
     if (s->commits.next =3D=3D 0)
-	return 0;
+        return 0;
=20
     vvfat_close_current_file(s);
=20
     ret =3D handle_renames_and_mkdirs(s);
     if (ret) {
-	fprintf(stderr, "Error handling renames (%d)\n", ret);
+        fprintf(stderr, "Error handling renames (%d)\n", ret);
         abort();
-	return ret;
+        return ret;
     }
=20
     /* copy FAT (with bdrv_read) */
@@ -2802,23 +2802,23 @@ static int do_commit(BDRVVVFATState* s)
     /* recurse direntries from root (using bs->bdrv_read) */
     ret =3D commit_direntries(s, 0, -1);
     if (ret) {
-	fprintf(stderr, "Fatal: error while committing (%d)\n", ret);
+        fprintf(stderr, "Fatal: error while committing (%d)\n", ret);
         abort();
-	return ret;
+        return ret;
     }
=20
     ret =3D handle_commits(s);
     if (ret) {
-	fprintf(stderr, "Error handling commits (%d)\n", ret);
+        fprintf(stderr, "Error handling commits (%d)\n", ret);
         abort();
-	return ret;
+        return ret;
     }
=20
     ret =3D handle_deletes(s);
     if (ret) {
-	fprintf(stderr, "Error deleting\n");
+        fprintf(stderr, "Error deleting\n");
         abort();
-	return ret;
+        return ret;
     }
=20
     if (s->qcow->bs->drv->bdrv_make_empty) {
@@ -2836,7 +2836,7 @@ static int try_commit(BDRVVVFATState* s)
     vvfat_close_current_file(s);
 DLOG(checkpoint());
     if(!is_consistent(s))
-	return -1;
+        return -1;
     return do_commit(s);
 }
=20
@@ -2862,56 +2862,56 @@ DLOG(checkpoint());
      */
=20
     if (sector_num < s->first_sectors_number)
-	return -1;
+        return -1;
=20
     for (i =3D sector2cluster(s, sector_num);
-	    i <=3D sector2cluster(s, sector_num + nb_sectors - 1);) {
-	mapping_t* mapping =3D find_mapping_for_cluster(s, i);
-	if (mapping) {
-	    if (mapping->read_only) {
-		fprintf(stderr, "Tried to write to write-protected file %s\n",
-			mapping->path);
-		return -1;
-	    }
-
-	    if (mapping->mode & MODE_DIRECTORY) {
-		int begin =3D cluster2sector(s, i);
-		int end =3D begin + s->sectors_per_cluster, k;
-		int dir_index;
-		const direntry_t* direntries;
-		long_file_name lfn;
-
-		lfn_init(&lfn);
-
-		if (begin < sector_num)
-		    begin =3D sector_num;
-		if (end > sector_num + nb_sectors)
-		    end =3D sector_num + nb_sectors;
-		dir_index  =3D mapping->dir_index +
-		    0x10 * (begin - mapping->begin * s->sectors_per_cluster);
-		direntries =3D (direntry_t*)(buf + 0x200 * (begin - sector_num));
-
-		for (k =3D 0; k < (end - begin) * 0x10; k++) {
-		    /* do not allow non-ASCII filenames */
-		    if (parse_long_name(&lfn, direntries + k) < 0) {
-			fprintf(stderr, "Warning: non-ASCII filename\n");
-			return -1;
-		    }
-		    /* no access to the direntry of a read-only file */
-		    else if (is_short_name(direntries+k) &&
-			    (direntries[k].attributes & 1)) {
-			if (memcmp(direntries + k,
-				    array_get(&(s->directory), dir_index + k),
-				    sizeof(direntry_t))) {
-			    fprintf(stderr, "Warning: tried to write to write-protected file\=
n");
-			    return -1;
-			}
-		    }
-		}
-	    }
-	    i =3D mapping->end;
-	} else
-	    i++;
+            i <=3D sector2cluster(s, sector_num + nb_sectors - 1);) {
+        mapping_t* mapping =3D find_mapping_for_cluster(s, i);
+        if (mapping) {
+            if (mapping->read_only) {
+                fprintf(stderr, "Tried to write to write-protected file =
%s\n",
+                        mapping->path);
+                return -1;
+            }
+
+            if (mapping->mode & MODE_DIRECTORY) {
+                int begin =3D cluster2sector(s, i);
+                int end =3D begin + s->sectors_per_cluster, k;
+                int dir_index;
+                const direntry_t* direntries;
+                long_file_name lfn;
+
+                lfn_init(&lfn);
+
+                if (begin < sector_num)
+                    begin =3D sector_num;
+                if (end > sector_num + nb_sectors)
+                    end =3D sector_num + nb_sectors;
+                dir_index  =3D mapping->dir_index +
+                    0x10 * (begin - mapping->begin * s->sectors_per_clus=
ter);
+                direntries =3D (direntry_t*)(buf + 0x200 * (begin - sect=
or_num));
+
+                for (k =3D 0; k < (end - begin) * 0x10; k++) {
+                    /* do not allow non-ASCII filenames */
+                    if (parse_long_name(&lfn, direntries + k) < 0) {
+                        fprintf(stderr, "Warning: non-ASCII filename\n")=
;
+                        return -1;
+                    }
+                    /* no access to the direntry of a read-only file */
+                    else if (is_short_name(direntries+k) &&
+                            (direntries[k].attributes & 1)) {
+                        if (memcmp(direntries + k,
+                                    array_get(&(s->directory), dir_index=
 + k),
+                                    sizeof(direntry_t))) {
+                            fprintf(stderr, "Warning: tried to write to =
write-protected file\n");
+                            return -1;
+                        }
+                    }
+                }
+            }
+            i =3D mapping->end;
+        } else
+            i++;
     }
=20
     /*
@@ -2920,14 +2920,14 @@ DLOG(checkpoint());
 DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num=
, nb_sectors));
     ret =3D bdrv_write(s->qcow, sector_num, buf, nb_sectors);
     if (ret < 0) {
-	fprintf(stderr, "Error writing to qcow backend\n");
-	return ret;
+        fprintf(stderr, "Error writing to qcow backend\n");
+        return ret;
     }
=20
     for (i =3D sector2cluster(s, sector_num);
-	    i <=3D sector2cluster(s, sector_num + nb_sectors - 1); i++)
-	if (i >=3D 0)
-	    s->used_clusters[i] |=3D USED_ALLOCATED;
+            i <=3D sector2cluster(s, sector_num + nb_sectors - 1); i++)
+        if (i >=3D 0)
+            s->used_clusters[i] |=3D USED_ALLOCATED;
=20
 DLOG(checkpoint());
     /* TODO: add timeout */
@@ -2966,7 +2966,7 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t off=
set, uint64_t bytes,
 }
=20
 static int64_t coroutine_fn vvfat_co_get_block_status(BlockDriverState *=
bs,
-	int64_t sector_num, int nb_sectors, int *n, BlockDriverState **file)
+        int64_t sector_num, int nb_sectors, int *n, BlockDriverState **f=
ile)
 {
     *n =3D bs->total_sectors - sector_num;
     if (*n > nb_sectors) {
@@ -3145,13 +3145,13 @@ static void checkpoint(void) {
     assert(!vvv->current_mapping || vvv->current_fd || (vvv->current_map=
ping->mode & MODE_DIRECTORY));
 #if 0
     if (((direntry_t*)vvv->directory.pointer)[1].attributes !=3D 0xf)
-	fprintf(stderr, "Nonono!\n");
+        fprintf(stderr, "Nonono!\n");
     mapping_t* mapping;
     direntry_t* direntry;
     assert(vvv->mapping.size >=3D vvv->mapping.item_size * vvv->mapping.=
next);
     assert(vvv->directory.size >=3D vvv->directory.item_size * vvv->dire=
ctory.next);
     if (vvv->mapping.next<47)
-	return;
+        return;
     assert((mapping =3D array_get(&(vvv->mapping), 47)));
     assert(mapping->dir_index < vvv->directory.next);
     direntry =3D array_get(&(vvv->directory), mapping->dir_index);
--=20
1.8.3.1
